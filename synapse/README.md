# Synapse Notes

`synapse/data` は生成後に作られます。ここには設定、media、signing key など重要データが入ります。

## Generate

```sh
docker compose --profile generate run --rm synapse-generate
```

## Production edits

生成後、`synapse/data/homeserver.yaml` を編集します。

```yaml
public_baseurl: "https://matrix.example.com/"

database:
  name: psycopg2
  args:
    user: synapse
    password: "replace-with-the-same-value-as-POSTGRES_PASSWORD"
    dbname: synapse
    host: postgres
    cp_min: 5
    cp_max: 10

enable_registration: false
allow_guest_access: false
```

## Create users

`registration_shared_secret` を一時的に設定した上で:

```sh
docker compose exec synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008
```

ユーザー作成が終わったら、必要がなければ `registration_shared_secret` を削除します。

## Must-backup data

- PostgreSQL dump
- `synapse/data/*.signing.key`
- `synapse/data/media_store`
- `synapse/data/homeserver.yaml`
- `caddy-data` volume

signing key を失うと homeserver の身元が変わるため、バックアップ対象から外さないでください。
