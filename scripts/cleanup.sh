#!/bin/bash

# 清理脚本 - 清理上传和解压的临时文件

UPLOAD_DIR="./uploads"
TEMP_DIR="$UPLOAD_DIR/temp"
EXTRACT_DIR="$UPLOAD_DIR/extracted"

echo "开始清理上传文件和临时目录..."

# 清理临时目录
if [ -d "$TEMP_DIR" ]; then
    echo "清理临时目录: $TEMP_DIR"
    rm -rf "$TEMP_DIR"/*
fi

# 询问是否清理解压目录
if [ -d "$EXTRACT_DIR" ] && [ "$(ls -A "$EXTRACT_DIR")" ]; then
    echo "解压目录包含以下内容:"
    ls -la "$EXTRACT_DIR"
    echo ""
    read -p "是否要清理解压目录? (y/N): " confirm
    case $confirm in
        [Yy]*)
            echo "清理解压目录: $EXTRACT_DIR"
            rm -rf "$EXTRACT_DIR"/*
            ;;
        *)
            echo "保留解压目录内容"
            ;;
    esac
else
    echo "解压目录为空或不存在"
fi

# 清理日志文件
if ls "$UPLOAD_DIR"/*.log 1> /dev/null 2>&1; then
    echo "清理日志文件"
    rm -f "$UPLOAD_DIR"/*.log
fi

echo "清理完成!"