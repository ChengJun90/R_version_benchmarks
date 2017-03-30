# R_version_benchmarks

本次Performance Benchmarks主要综合了[微软的测试代码](https://github.com/andrie/version.compare)和[Julia的测试代码](https://github.com/JuliaLang/julia/blob/master/test/perf/micro/perf.R)，并且新增了dataframe和regression的测试。测试包采用的是microbenchmark。

microbenchmark.R是测试代码。  
visualization.R是测试结果的分析。

参与测试的版本：
- Microsoft R Open 3.3.2 Using the Intel MKL for parallel mathematical computing(using 2 cores)
- R version 3.3.3 (2017-03-06) 
- R version 3.4.0 alpha (2017-03-28 r72427)
