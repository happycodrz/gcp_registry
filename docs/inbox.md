# 2019/01/31:

Docs:

- https://ahmet.im/blog/google-container-registry-tips/
- https://cloud.google.com/sdk/gcloud/reference/container/images/
- https://cloud.google.com/sdk/gcloud/reference/container/images/list
- https://cloud.google.com/sdk/gcloud/reference/container/images/add-tag

Elixir Date conversion:

  `DateTime.from_unix(1545128977698, :millisecond) -> for milliseconds`


Example commands for reverse-engineering:

```bash
$ gcloud --log-http --verbosity info container images list-tags eu.gcr.io/${PROJECT_ID}
$ gcloud --log-http --verbosity info container images list eu.gcr.io/${PROJECT_ID}
$ gcloud --log-http container images list --filter "name:master"  --repository=eu.gcr.io/${PROJECT_ID}
```
