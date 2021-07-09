# Using the Amazon Redshift Data API to interact from an Amazon SageMaker Jupyter notebook

In this AWS Sample code, you will learn how to use [Amazon Redshift Data API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) to access your Amazon Redshift Data Warehouse seamlessly using [Amazon Sagemaker Notebook](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi.html), which is very popular with the data scientist community.

In this repository, we are demonstrating how to use Redshift Data API to access and visualize data from Redshift and create an regression ML model with Redshift ML as explained in this [AWS Blogpost](https://aws.amazon.com/blogs/machine-learning/build-regression-models-with-amazon-redshift-ml/).

Here is the [ipython notebook file](Redshift ML with Data API.ipynb) used in this demonstration, which connects with Amazon Redshift using IAM credentials without any password management hassles. It then fetches Redshift data directly into a Pandas data frame, which makes it easy and seamless for data scientists to work and analyze that data. At the end, we created an ML model in Amazon Redshift ML and ran predictions from that model.

You may provision this notebook instance using this [CloudFormation Template](cf-template-sagemaker-notebook.yaml) after inputting below parameters. It needs your Redshift cluster endpoint and VPC, Subnet  info for that cluster to provision a notebook instance, which can connect and query that cluster.
[cftemplate inputs](images/cft.png)
