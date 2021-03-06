# 使用 GitHub Workflow 自动构建和部署文档网站

介绍我是如何使用 GitHub Workflow 和 Swift DocC Plugin 把代码中的注释编译成这个网站的。

[Swift DocC Plugin](https://github.com/apple/swift-docc-plugin) 是一个
Swift Package Manager 命令插件，用于直接构建 DocC 文档归档，并可用于静态网页托管服务。
其使用文档位于 
[https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/)。

本仓库在 GitHub Workflow 中调用 Swift DocC Plugin 生成文档网站并部署到 GitHub Pages。

## 网站构建脚本
首先在 Swift Package 清单文件中添加 Swift DocC Plugin 的依赖：

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // targets
    ]
)
```

然后参照文章 [Publishing to GitHub Pages](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages) 
和脚本文件
[https://github.com/apple/swift-docc-plugin/blob/main/bin/update-gh-pages-documentation-site](https://github.com/apple/swift-docc-plugin/blob/main/bin/update-gh-pages-documentation-site)
，编写适用此仓库的构建脚本。

GitHub Pages 支持自动将 `gh-pages` 分支下的内容发布出来，也支持自定义其他分支。可以发布分支根目录，
也可以发布分支下的 `docs` 目录。为了便于脚本编写，我使用 `gh-pages` 分支下的 `docs` 目录。
这里使用 `git worktree` 将 `gh-pages` 分支签出到一个子目录，便于处理。

```bash
git worktree add --checkout gh-pages origin/gh-pages
```

然后编译文档网站：

```bash
# Pretty print DocC JSON output so that it can be consistently diffed between commits
export DOCC_JSON_PRETTYPRINT="YES"

# Generate documentation and output it
# to the /docs subdirectory in the gh-pages worktree directory.
export SWIFTPM_ENABLE_COMMAND_PLUGINS=1
swift package \
    --allow-writing-to-directory "gh-pages/docs" \
    generate-documentation \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path "/LeetCode" \
    --output-path "gh-pages/docs"
```

DocC 编译的文档网站首页是一个 404 页面，对于网站访问者来说非常不友好。
这里我使用一个包含跳转指令的 HTML 页面替换 DocC 生成的首页：

```html
<html>
    <head>
        <meta http-equiv="refresh" content="0; url=documentation/leetcode/" />
    </head>
    <body>
        <p><a href="documentation/leetcode/">Redirect</a></p>
    </body>
</html>

```

```bash
cp BuildTools/custom-index.html gh-pages/docs/index.html
```

接下来，在网站根目录添加一个 `.nojekyll` 文件防止 GitHub 尝试使用 Jekyll 编译 DocC 生成的网站：

```bash
touch gh-pages/docs/.nojekyll
```

最后，将生成的内容提交到 `gh-pages` 分支并清理 Git 工作树：

```
# Save the current commit we've just built documentation from in a variable
CURRENT_COMMIT_HASH=`git rev-parse --short HEAD`

# Commit and push our changes to the gh-pages branch
cd gh-pages
git add docs

if [ -n "$(git status --porcelain)" ]; then
    echo "Documentation changes found. Commiting the changes to the 'gh-pages' branch and pushing to origin."
    git commit -m "Update GitHub Pages documentation site to '$CURRENT_COMMIT_HASH'."
    git push origin HEAD:gh-pages
else
  # No changes found, nothing to commit.
  echo "No documentation changes found."
fi

# Delete the git worktree we created
cd ..
git worktree remove gh-pages
```

完整的构建脚本位于仓库的 `BuildTools/build-doc.sh`。

## 配置 GitHub 自动部署
要启用 GitHub 自动部署，在仓库根目录创建一个 `.github/workflows` 目录。每一个工作流是一个
YAML 文件，可以随意命名。

```yaml
name: Swift

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-documentation:
    name: 构建文档网站
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v3
    - uses: fwal/setup-swift@v1
    - name: Build
      run: ./BuildTools/build-doc.sh
```

这里指定 “main” 分支的推送和合并请求事件，定义了一个 job，在 job 中使用了
`actions/checkout@v3` 和 `fwal/setup-swift@v1` 两个 Action，最后使用构建脚本执行构建操作。

GitHub Runner 不会自动拉取仓库，也不会自动准备 swift 环境，因此需要使用上述两个 Action。他们的仓库地址为
[https://github.com/actions/checkout](https://github.com/actions/checkout)
和
[https://github.com/fwal/setup-swift](https://github.com/fwal/setup-swift)。

在 GitHub 仓库中配置 Pages 数据源后，当指定分支更新就会自动更新 GitHub Pages。因此，每当推动 main 
分支后就会首先执行我们指定的 Workflow，随后由构建脚本中的 `git push origin HEAD:gh-pages`
指令除法 GitHub Pages 更新。

## 修订历史
| 时间 | 修订 |
| --- | --- |
| `2022-04-26T15:07:57+08:00` | 创建。 |

## Topics

### 历史版本

- <doc:Manually-Build-Website>
