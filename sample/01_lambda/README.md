# sample/01_lambda

terraform-managerの基本的な使い方を示すサンプルです。シンプルなAWS Lambda関数を作成します。

## 前提条件

- AWS CLIの設定が完了していること（`aws configure`）
- Terraformがインストールされていること
- terraform-managerがビルドされていること

## リソース

このサンプルでは以下のAWSリソースを作成します：

- Lambda関数（Python 3.12ランタイム）
- Lambda実行用のIAMロール
- 基本的な実行ポリシー

## デフォルト設定ファイル

terraform-managerは `~/.config/terraform-manager/default.yaml` を読み込みます：

```yaml
terraform_dir: /path/to/clojure-terraform-manager/sample/01_lambda
```

または、絶対パスで指定：

```bash
mkdir -p ~/.config/terraform-manager
cat > ~/.config/terraform-manager/default.yaml <<EOF
terraform_dir: $PWD
EOF
```

## 使い方

### 1. デフォルト設定を使う場合

```bash
# 設定ファイルを作成
mkdir -p ~/.config/terraform-manager
cat > ~/.config/terraform-manager/default.yaml <<EOF
terraform_dir: $(pwd)
EOF

# dry-runで確認
terraform-manager switch -n

# 実行
terraform-manager switch
```

### 2. コマンドラインでディレクトリを指定する場合

```bash
# dry-runで確認
terraform-manager switch -f sample/01_lambda -n

# 実行
terraform-manager switch -f sample/01_lambda
```

### 3. 直接Terraformコマンドを使う場合

```bash
cd sample/01_lambda

# 初期化
terraform init

# プラン確認
terraform plan

# 適用
terraform apply

# 削除
terraform destroy
```

## 変数のカスタマイズ

変数を上書きする場合は、`terraform.tfvars`を作成します：

```hcl
aws_region    = "us-east-1"
function_name = "my-custom-function-name"
```

## 期待される出力

```
function_arn  = "arn:aws:lambda:ap-northeast-1:123456789012:function:terraform-manager-sample-function"
function_name = "terraform-manager-sample-function"
```

## クリーンアップ

作成したリソースを削除する場合：

```bash
cd sample/01_lambda
terraform destroy
```

または

```bash
terraform-manager destroy -f sample/01_lambda
```

（destroy コマンドは今後実装予定）
