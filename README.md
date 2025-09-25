# 2025-c-
我的一些代码开源及一些有趣的代码脚本

## 功能特性

### 压缩文件处理
支持多种压缩格式的文件上传和解压处理：
- ZIP (.zip)
- TAR.GZ (.tar.gz, .tgz)
- TAR.BZ2 (.tar.bz2, .tbz2)
- RAR (.rar)
- 7Z (.7z)

### 目录结构
```
├── uploads/          # 文件上传目录
│   ├── temp/        # 临时文件目录
│   └── extracted/   # 解压文件目录
├── scripts/         # 工具脚本
│   ├── extract_archive.sh  # 压缩文件解压脚本
│   └── cleanup.sh          # 清理脚本
└── README.md        # 项目说明
```

### 使用方法

#### 解压压缩文件
```bash
# 解压压缩文件到 uploads/extracted/ 目录
./scripts/extract_archive.sh path/to/your/archive.zip
```

#### 清理临时文件
```bash
# 清理上传和临时文件
./scripts/cleanup.sh
```

## 注意事项
- 确保上传的文件安全可靠
- 大文件处理可能需要较长时间
- 定期清理不需要的文件以节省空间
