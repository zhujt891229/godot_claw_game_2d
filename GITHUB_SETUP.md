# 🚀 上传项目到 GitHub 完整指南

## 方法一：使用 Git 命令行 (推荐)

### 步骤 1: 在 GitHub 创建新仓库

1. 访问 https://github.com
2. 点击右上角 `+` → `New repository`
3. 填写信息：
   - **Repository name**: `godot-platformer` (或你喜欢的名字)
   - **Description**: `2D Platformer Game made with Godot 4.6`
   - **Public/Private**: 根据需求选择
   - **不要勾选** "Initialize this repository with a README"
4. 点击 `Create repository`

---

### 步骤 2: 初始化本地仓库

打开终端，执行：

```bash
# 进入项目目录
cd /home/admin/.openclaw/workspace/godot-game

# 初始化 Git
git init

# 添加所有文件
git add .

# 第一次提交
git commit -m "Initial commit: Godot 4.6 2D platformer project"
```

---

### 步骤 3: 关联 GitHub 仓库

在 GitHub 仓库页面会看到类似这样的提示：

```bash
git remote add origin https://github.com/你的用户名/godot-platformer.git
git branch -M main
git push -u origin main
```

**替换成你的仓库地址**，然后执行：

```bash
# 关联远程仓库 (替换成你的仓库 URL)
git remote add origin https://github.com/你的用户名/你的仓库名.git

# 重命名分支为 main
git branch -M main

# 推送到 GitHub
git push -u origin main
```

---

### 步骤 4: 验证上传

1. 刷新 GitHub 仓库页面
2. 应该能看到所有文件
3. 确认 `.gitignore` 生效 (`.godot/` 等文件不应该上传)

---

## 方法二：使用 GitHub Desktop (图形界面)

### 步骤 1: 下载安装

- 访问：https://desktop.github.com
- 下载并安装 GitHub Desktop

### 步骤 2: 添加项目

1. 打开 GitHub Desktop
2. `File` → `Add Local Repository`
3. 选择项目目录：`/home/admin/.openclaw/workspace/godot-game`
4. 如果提示不是仓库，点击 `Create a repository`

### 步骤 3: 发布到 GitHub

1. 点击右上角 `Publish repository`
2. 填写仓库信息
3. 点击 `Publish`

---

## 方法三：使用 Godot 内置 Git 插件

### 步骤 1: 安装插件

1. 打开 Godot
2. `AssetLib` 标签页
3. 搜索 `Git` 或 `GitHub`
4. 安装插件 (如 `Godot Git Plugin`)

### 步骤 2: 配置

1. `Project` → `Project Settings` → `Plugins`
2. 启用 Git 插件
3. 按照插件指引操作

---

## 📝 后续提交代码

每次修改后，执行：

```bash
# 查看变更
git status

# 添加变更
git add .

# 提交
git commit -m "描述你的修改，如：添加玩家跳跃功能"

# 推送到 GitHub
git push
```

---

## ⚠️ 注意事项

### 不应该上传的文件

`.gitignore` 已配置，以下文件**不会**上传：

- `.godot/` - Godot 编辑器缓存
- `*.import` - 导入缓存
- `*.tmp` - 临时文件
- `builds/` - 导出文件
- `exports/` - 导出文件

### 应该上传的文件

- `project.godot` - 项目配置
- `*.tscn` - 场景文件
- `*.gd` - 脚本文件
- `*.tres` - 资源文件
- `assets/` - 素材文件 (注意版权)

### 素材版权注意

如果你的素材是 CC0 或允许分发，可以上传。否则：
- 在 `.gitignore` 中添加 `assets/sprites/`
- 在 README 中说明素材来源
- 使用 Git LFS 管理大文件

---

## 🔧 常见问题

### Q: 提示 "remote origin already exists"？
```bash
git remote remove origin
git remote add origin https://github.com/你的用户名/你的仓库.git
```

### Q: 推送失败，提示权限问题？
- 检查 GitHub 用户名和密码
- 或使用 SSH 方式：`git@github.com:用户名/仓库.git`
- 或使用 Personal Access Token

### Q: 文件太大无法上传？
```bash
# 安装 Git LFS
git lfs install

# 追踪大文件
git lfs track "*.png"
git lfs track "*.mp3"
git lfs track "*.ogg"

# 重新添加
git add .gitattributes
git add .
git commit -m "Add LFS tracking"
git push
```

### Q: 想修改最后一次提交的信息？
```bash
git commit --amend -m "新的提交信息"
git push --force
```

---

## 🎯 推荐工作流

```bash
# 每天工作结束前
git add .
git commit -m "完成 XXX 功能"
git push

# 开始新工作前
git pull
```

---

## 📖 相关资源

- Git 教程：https://git-scm.com/book/zh/v2
- GitHub 文档：https://docs.github.com/zh
- Godot 版本控制：https://docs.godotengine.org/zh/stable/tutorials/assetlib/vcs.html

---

_最后更新：2026-05-09 | 小虾 🦐_
