## R Packages to Install

- ppclust
- factoextra
- cluster
- fclust

<br />

- Activate virtual environment

```bash
# Activate r_env virtual R environment
conda activate r_env
```

- Interactively enter R shell

```
R
```

- Install the above packages using environment above:

```bash
install.packages(c('ppclust', 'factoextra', 'cluster', 'fclust'))
```

- Create a Jupyter kernel for R

```bash
install.packages('IRkernel')
```

- Install Kernel with Name

```bash
IRkernel::installspec(name = 'ir33', displayname = 'R Environment 2023')
```

- [Kaggle Exercise](https://www.kaggle.com/code/ysthehurricane/fuzzy-c-means-clustering-tutorial-r)
- [CRAN ppclust Demo](https://cran.r-project.org/web/packages/ppclust/vignettes/fcm.html#)
- [ppclust documentation](https://www.rdocumentation.org/packages/ppclust/versions/1.1.0/topics/ppclust2)
