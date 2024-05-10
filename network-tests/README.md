# Network Tests

This directory presents the results of Network and Performance tests.

The Test Results titled V3 were used as the final version to produce our Test Report.

## Structure

Each folder presents a test iteration. There were 3 iterations of tests which were used to improve the accuracy and reliability of our results.

Each folder contains the below subfolders, but their content may vary.

### Diagrams

`Diagrams` folder contains screenshots of the resource usage of the components that were involved in testing (e.g. ingresses, test applications)

Below you can see the structure of `Diagrams` folder:

```txt
.
└── diagrams
    └── <service-mesh>
        └── <starting-point>
            ├── <test-application-1>
            │   └── <results>
            └── <test-application-2>
                └── <results>
```

### oha-results

`oha-results` folder presents `oha` command outputs in different formats:

* You can find raw data that was uploaded to the S3 bucket immediately after the script was executed in the `s3-bucket` folder.
* You can find structured colorized results with an HTML extension in `colorized` folder.
* You can find structured non-colorized results with a TXT extension in `non-colorized` folder.

Below you can see the structure of `colorized` and `non-colorized` folders:

```txt
.
└── <folder-name>
    └── <service-mesh>
        └── <starting-point>
            ├── <test-application-1>
            │   └── <results>
            └── <test-application-2>
                └── <results>
```
