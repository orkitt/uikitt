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

if [ ! -f "$CONFIG_FILE" ]; then
  echo -e "${RED}❌ orkitt.yaml not found${NC}"
  exit 1
fi

# Read workspace folder from YAML
WORKSPACE_DIR=$(grep "^name:" "$CONFIG_FILE" | awk '{print $2}')
echo -e "${BLUE}Workspace folder detected:${NC} '$WORKSPACE_DIR'"

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo -e "${RED}❌ Workspace folder '$WORKSPACE_DIR' not found${NC}"
  exit 1
fi

# Collect packages
PACKAGES=()

# Check umbrella package
if [ -f "$WORKSPACE_DIR/orkitt/pubspec.yaml" ]; then
  echo -e "✅ Found umbrella package: $WORKSPACE_DIR/orkitt"
  PACKAGES+=("$WORKSPACE_DIR/orkitt")
fi

# Check subfolders in packages/
PKG_DIR="$WORKSPACE_DIR/packages"
if [ -d "$PKG_DIR" ]; then
  for sub in "$PKG_DIR"/*; do
    if [ -d "$sub" ] && [ -f "$sub/pubspec.yaml" ]; then
      echo -e "✅ Found subpackage: $sub"
      PACKAGES+=("$sub")
    fi
  done
else
  echo -e "${YELLOW}⚠️  Packages folder not found: $PKG_DIR${NC}"
fi

TOTAL=${#PACKAGES[@]}
if [ "$TOTAL" -eq 0 ]; then
  echo -e "${YELLOW}⚠️  No valid packages found${NC}"
  exit 0
fi

echo -e "${BLUE}Final list of packages:${NC}"
for p in "${PACKAGES[@]}"; do
  echo "  $p"
done

# Function to run a command in all packages
run_for_all() {
  local cmd="$1"
  echo -e "\n${BLUE}▶ Running '$cmd' across $TOTAL packages...${NC}\n"
  for pkg in "${PACKAGES[@]}"; do
    echo -e "${YELLOW}📦 [$pkg]${NC}"
    (cd "$pkg" && eval "$cmd") || {
      echo -e "${RED}❌ Failed in $pkg${NC}"
      exit 1
    }
    echo ""
  done
}

# Main command switch
case "$1" in
  bootstrap)
    run_for_all "flutter pub get"
    ;;
  analyze)
    run_for_all "flutter analyze"
    ;;
  test)
    run_for_all "flutter test"
    ;;
  version)
    if [ -z "$2" ]; then
      echo -e "${YELLOW}⚠️  Usage: ./orkitt.sh version 1.0.0${NC}"
      exit 1
    fi
    version="$2"
    echo -e "${BLUE}📦 Updating all package versions to $version${NC}"
    for pkg in "${PACKAGES[@]}"; do
      if [ -f "$pkg/pubspec.yaml" ]; then
        sed -i '' "s/^version:.*/version: $version/" "$pkg/pubspec.yaml" || true
        echo -e "✅ Updated $pkg/pubspec.yaml"
      fi
    done
    ;;
  *)
    echo -e "${YELLOW}Usage:${NC} ./orkitt.sh [bootstrap|analyze|test|version <v>]"
    ;;
esac

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
echo -e "\n${GREEN}✅ Done in ${ELAPSED}s | $TOTAL packages processed.${NC}"
