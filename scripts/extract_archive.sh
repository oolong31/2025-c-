#!/bin/bash

# 压缩文件处理脚本
# 自动检测压缩文件类型并解压到相应目录

UPLOAD_DIR="./uploads"
TEMP_DIR="$UPLOAD_DIR/temp"
EXTRACT_DIR="$UPLOAD_DIR/extracted"

# 创建必要的目录
mkdir -p "$TEMP_DIR" "$EXTRACT_DIR"

# 检查参数
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <压缩文件路径>"
    echo "支持的格式: .zip, .tar.gz, .tar.bz2, .rar, .7z"
    exit 1
fi

ARCHIVE_FILE="$1"

# 检查文件是否存在
if [ ! -f "$ARCHIVE_FILE" ]; then
    echo "错误: 文件 '$ARCHIVE_FILE' 不存在"
    exit 1
fi

# 获取文件名（不含路径）
FILENAME=$(basename "$ARCHIVE_FILE")
# 获取文件名（不含扩展名）
BASENAME="${FILENAME%.*}"

# 创建解压目标目录
TARGET_DIR="$EXTRACT_DIR/$BASENAME"
mkdir -p "$TARGET_DIR"

echo "正在处理文件: $FILENAME"
echo "解压到目录: $TARGET_DIR"

# 根据文件扩展名选择解压方法
case "$FILENAME" in
    *.zip)
        if command -v unzip >/dev/null 2>&1; then
            unzip -q "$ARCHIVE_FILE" -d "$TARGET_DIR"
            echo "ZIP 文件解压完成"
        else
            echo "错误: 未找到 unzip 命令"
            exit 1
        fi
        ;;
    *.tar.gz|*.tgz)
        tar -xzf "$ARCHIVE_FILE" -C "$TARGET_DIR"
        echo "TAR.GZ 文件解压完成"
        ;;
    *.tar.bz2|*.tbz2)
        tar -xjf "$ARCHIVE_FILE" -C "$TARGET_DIR"
        echo "TAR.BZ2 文件解压完成"
        ;;
    *.tar)
        tar -xf "$ARCHIVE_FILE" -C "$TARGET_DIR"
        echo "TAR 文件解压完成"
        ;;
    *.rar)
        if command -v unrar >/dev/null 2>&1; then
            cd "$TARGET_DIR"
            unrar x "$ARCHIVE_FILE"
            cd - >/dev/null
            echo "RAR 文件解压完成"
        else
            echo "错误: 未找到 unrar 命令"
            exit 1
        fi
        ;;
    *.7z)
        if command -v 7z >/dev/null 2>&1; then
            7z x "$ARCHIVE_FILE" -o"$TARGET_DIR"
            echo "7Z 文件解压完成"
        else
            echo "错误: 未找到 7z 命令"
            exit 1
        fi
        ;;
    *)
        echo "错误: 不支持的文件格式 '$FILENAME'"
        echo "支持的格式: .zip, .tar.gz, .tar.bz2, .rar, .7z"
        exit 1
        ;;
esac

echo "解压完成! 文件已解压到: $TARGET_DIR"

# 显示解压后的内容概要
echo ""
echo "解压后的内容:"
ls -la "$TARGET_DIR"