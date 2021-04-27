# benchmark-k8s-cni-2021-05

The benchmark is based on `knb` from the [k8s-bench-suite](https://github.com/InfraBuilder/k8s-bench-suite).

## Benchmark protocol

See [PROTOCOL.md](PROTOCOL.md)

## CNI selection

Conditions for a CNI to be benchmarked are :
- it must setup on on-premise bare-metal cluster
- it must be easy to setup (a yaml manifest, a helm chart, or an operator)
- it must not relies on proprietary hardware

## Run example

All benchmark runs are recorded with [record-bench.sh](record-bench.sh) which uses [Asciinema](https://asciinema.org/) :

[record-bench.sh](record-bench.sh) starts asciinema recording, and call [benchmark.sh](benchmark.sh) who is in charge of :
- setup lab
- setup cni
- run 3 rounds of benchmark, save data to knbdata files
- teardown lab

Please note that [benchmark.sh](benchmark.sh) uses [setup.sh](setup.sh), the node deployment script that is tailored for our MaaS-based lab environment. 

Example :

[![asciicast](https://asciinema.org/a/NXrptSXsjqEeYQn4Hg1R7gb5O.png)](https://asciinema.org/a/NXrptSXsjqEeYQn4Hg1R7gb5O)

## Results 

### User friendly results 

Results for human being with charts and interpretation are available in an article on Medium. 

Work in progress ... Still writing it for now.

### Aggregated results

You can also check aggregated results on the spreadsheet here :
https://docs.google.com/spreadsheets/d/1M8vtxTBN_5Ih36B5lPsZy6w56p85YaCXhxIVFCrtZXc/edit?usp=sharing

Values injected in the spreadsheet are in files `results/<cni>.<distrib>-<kernel>/<cni>.<distrib>-<kernel>-run<x>.tsv`

### Raw results

Raw results are available in this repository, just check the [results](results) directory for `*.knbdata` files. 
You can generate reports with [knb](https://github.com/InfraBuilder/k8s-bench-suite), for example :

```bash
knb -fd results/antrea-default.u20.04-hwe/antrea-default.u20.04-hwe-run1.knbdata -o text
# or
knb -fd results/doc-antrea.u18.04-default/doc-antrea.u18.04-default-run1.knbdata -o json
# or
knb -fd results/doc-antrea.u18.04-default/doc-antrea.u18.04-default-run1.knbdata -o yaml
```

As `knbdata` files are just simple tar.gz archives, you can also uncompress the file to see raw containers logs (showing data even before being parsed by `knb`)
