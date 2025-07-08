# カスタムテーマディレクトリ

このディレクトリは、Keycloak のカスタムテーマを配置するためのものです。

## 使用方法

1. カスタムテーマのディレクトリを作成します
2. テーマファイルを配置します
3. Keycloak コンテナを再起動します

## テーマの構造例

```
themes/
├── my-custom-theme/
│   ├── login/
│   │   ├── theme.properties
│   │   └── template.ftl
│   ├── account/
│   │   ├── theme.properties
│   │   └── template.ftl
│   └── admin/
│       ├── theme.properties
│       └── resources/
│           └── css/
│               └── styles.css
```

詳細については、[Keycloak 公式ドキュメント](https://www.keycloak.org/docs/latest/server_development/#_themes)を参照してください。
