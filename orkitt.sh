#!/usr/bin/env bash
set -e

CONFIG_FILE="orkitt.yaml"
START_TIME=$(date +%s)

BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${BLUE}🔹 Starting Orkitt script...${NC}"

# --- Check for orkitt.yaml ---
if [ ! -f "$CONFIG_FILE" ]; then
  echo -e "${RED}❌ orkitt.yaml not found${NC}"
  exit 1
fi

# --- Detect workspace folder ---
WORKSPACE_DIR=$(grep "^name:" "$CONFIG_FILE" | awk '{print $2}')
echo -e "${BLUE}Workspace folder detected:${NC} '$WORKSPACE_DIR'"

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo -e "${RED}❌ Workspace folder '$WORKSPACE_DIR' not found${NC}"
  exit 1
fi

# --- Collect packages ---
UMBRELLA_PACKAGE="$WORKSPACE_DIR/orkitt"
SUB_PACKAGES=()

# Detect sub-packages
PKG_DIR="$WORKSPACE_DIR/packages"
if [ -d "$PKG_DIR" ]; then
  for sub in "$PKG_DIR"/*; do
    if [ -d "$sub" ] && [ -f "$sub/pubspec.yaml" ]; then
      echo -e "✅ Found subpackage: $sub"
      SUB_PACKAGES+=("$sub")
    fi
  done
else
  echo -e "${YELLOW}⚠️  Packages folder not found: $PKG_DIR${NC}"
fi

# Debug final list
echo -e "${BLUE}Final list of packages:${NC}"
for p in "${SUB_PACKAGES[@]}"; do
  echo "  $p"
done
echo "  $UMBRELLA_PACKAGE (umbrella package)"

# --- Helper function to run command in packages ---
run_for_packages() {
  local cmd="$1"
  shift
  local pkgs=("$@")
  echo -e "\n${BLUE}▶ Running '$cmd' across ${#pkgs[@]} packages...${NC}\n"
  for pkg in "${pkgs[@]}"; do
    echo -e "${YELLOW}📦 [$pkg]${NC}"
    (cd "$pkg" && eval "$cmd") || {
      echo -e "${RED}❌ Failed in $pkg${NC}"
      exit 1
    }
    echo ""
  done
}

# --- Helper function to publish umbrella package ---
publish_umbrella() {
  local pkg="$UMBRELLA_PACKAGE"
  local pubspec="$pkg/pubspec.yaml"

  if [ ! -f "$pubspec" ]; then
    echo -e "${RED}❌ Umbrella pubspec.yaml not found: $pubspec${NC}"
    return
  fi

  echo -e "${BLUE}🔹 Preparing umbrella package for publish...${NC}"

  # Backup original pubspec
  cp "$pubspec" "$pubspec.bak"

  # Comment out publish_to
  sed -i '' 's/^publish_to:.*/# &/' "$pubspec"

  # Comment out path dependencies
  sed -i '' '/path: ../packages/ s/^/  # /' "$pubspec"

  # Dry-run publish
  echo -e "${BLUE}▶ Running dart pub publish --dry-run${NC}"
  (cd "$pkg" && dart pub publish --dry-run)

  # Actual publish
  echo -e "${BLUE}▶ Running dart pub publish${NC}"
  (cd "$pkg" && dart pub publish)

  # Restore original pubspec
  mv "$pubspec.bak" "$pubspec"
  echo -e "${GREEN}✅ Umbrella package published and pubspec restored.${NC}"
}

# --- Main command switch ---
case "$1" in
  bootstrap)
    run_for_packages "flutter pub get" "${SUB_PACKAGES[@]}" "$UMBRELLA_PACKAGE"
    ;;
  analyze)
    run_for_packages "flutter analyze" "${SUB_PACKAGES[@]}" "$UMBRELLA_PACKAGE"
    ;;
  test)
    run_for_packages "flutter test" "${SUB_PACKAGES[@]}" "$UMBRELLA_PACKAGE"
    ;;
  version)
    if [ -z "$2" ]; then
      echo -e "${YELLOW}⚠️  Usage: ./orkitt.sh version 1.0.0${NC}"
      exit 1
    fi
    version="$2"
    echo -e "${BLUE}📦 Updating all package versions to $version${NC}"
    for pkg in "${SUB_PACKAGES[@]}" "$UMBRELLA_PACKAGE"; do
      if [ -f "$pkg/pubspec.yaml" ]; then
        sed -i '' "s/^version:.*/version: $version/" "$pkg/pubspec.yaml" || true
        echo -e "✅ Updated $pkg/pubspec.yaml"
      fi
    done
    ;;
  pub-dry)
    run_for_packages "dart pub publish --dry-run" "${SUB_PACKAGES[@]}"
    publish_umbrella
    ;;
  pub)
    run_for_packages "dart pub publish" "${SUB_PACKAGES[@]}"
    publish_umbrella
    ;;
  *)
    echo -e "${YELLOW}Usage:${NC} ./orkitt.sh [bootstrap|analyze|test|version <v>|pub-dry|pub]"
    ;;
esac

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo -e "\n${GREEN}✅ Done in ${ELAPSED}s | $(( ${#SUB_PACKAGES[@]} + 1 )) packages processed.${NC}"
