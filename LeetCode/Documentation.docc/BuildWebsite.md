# 关于生成的网站

介绍我是如何使用 Swift DocC 把代码中的注释编译成这个网站的。

## Overview

[Swift-DocC](https://github.com/apple/swift-docc) 用于将 Swift 
项目中的文档注释编译成开发者文档，编译后的文档也可以导出为 Web 单页面应用。
Xcode 13 附带了 Swift DocC 工具，也包含 `docc` 命令行工具，
见 [Getting Started with docc](ttps://github.com/apple/swift-docc#getting-started-with-docc)。

> Tip: 如果安装 Xcode 后无法直接从命令行运行 `docc`，
> 可以使用 xcrun 工具来运行：
> 
> ```bash
> xcrun docc
> ```

> Tip: 可以使用 help 子命令查看帮助：
> ```bash
> xcrun docc help
> ```


## 导出文档网站
基于我的工作流程，我选择使用 Xcode 编译代码和文档，将文档导出，然后转换为静态网站。
导出的 doccarchive 目录结构如下：

```
LeetCode.doccarchive
├── css/
├── data
│   └── documentation
│       ├── leetcode
│       │   ├── example
│       │   │   ├── answer.json
│       │   │   ├── init(input:answer:).json
│       │   │   └── input.json
│       │   ├── example.json
│       │   ├── ...
│       │   └── usage.json
│       └── leetcode.json
├── downloads/
├── favicon.ico
├── favicon.svg
├── images/
├── img/
├── index/
├── index.html
├── js/
├── metadata.json
├── theme-settings.json
└── videos
```

`docc` 的 `process-archive` 自命令用于处理 Xcode 导出的 doccarchive。
其 `transform-for-static-hosting` 自命令用于将 Web 单页应用转换为普通静态页面。

```bash
xcrun docc process-archive \
    transform-for-static-hosting \
    LeetCode.doccarchive \
    --hosting-base-path "/LeetCode"
```

`docc` 转换静态网站的过程实际上就是在导出的 doccarchive 中为每一个页面添加一个 `index.html`，
使 Web 单页应用变为普通静态网站，即下面的 `documentation` 目录：

```
LeetCode.doccarchive
├── css/
├── data
│   └── documentation
│       ├── leetcode
│       │   ├── example
│       │   │   ├── answer.json
│       │   │   ├── init(input:answer:).json
│       │   │   └── input.json
│       │   ├── example.json
│       │   ├── ...
│       │   └── usage.json
│       └── leetcode.json
├── documentation
│   └── leetcode
│       ├── example
│       │   ├── answer
│       │   │   └── index.html
│       │   ├── index.html
│       │   ├── init(input:answer:)
│       │   │   └── index.html
│       │   └── input
│       │       └── index.html
│       ├── index.html
│       ├── ...
│       └── usage
│           └── index.html
├── ...
└── index.html

35 directories, 86 files
```

`--hosting-base-path` 参数用于指定 URL 路径前缀。在 GitHub Pages 中，仓库的网站位于
"`https://用户名.github.io/仓库名/`"，因此需要使用此参数指定路径前缀 "`/仓库名`"。

## 部署到 GitHub Pages
GitHub 会自动将仓库的 gh-pages 分支作为仓库网站发布。当然也可以指定其他的分支或者分支下的 “docs”
目录。

创建并切换到 gh-pages 分支，然后删除当前分支下的文件替换为 doccarchive 中的内容。
为了防止 GitHub 使用 Jekyll 处理编译后的静态网站，在 gh-pages 的根目录创建一个 `.nojekyll`
文件。

docc 转换网站时没有处理网站根目录的 index.html，因此直接部署到 GitHub pages 上会显示为空白。
Swift DocC 创建的文档位于 “/路径前缀/documentation/项目名称小写”，分步指导位于 
“/路径前缀/documentation/项目名称小写”。这里我创建一个空的首页，直接跳转到文档页面：

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

完成上述所有工作后即可提交到 gh-pages 分支，并推送到 GitHub。
