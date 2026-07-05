# Databricks notebook source
import pandas as pd

# COMMAND ----------

df = pd.read_csv("/Workspace/Users/khushisingh.happy2001@gmail.com/Drafts/Sample - Superstore.csv",encoding='ISO-8859-1')

# COMMAND ----------

df.head()

# COMMAND ----------

df.tail()

# COMMAND ----------

df.shape

# COMMAND ----------

df.columns

# COMMAND ----------

df.dtypes

# COMMAND ----------

df.info()

# COMMAND ----------

df.isnull()

# COMMAND ----------

df.isnull().sum()

# COMMAND ----------

df.fillna("unknown")

# COMMAND ----------

df[df["Sales"]>400]

# COMMAND ----------

df[df["Category"]== "Furniture"]

# COMMAND ----------

df[["Category","Sales"]]

# COMMAND ----------

df.duplicated()

# COMMAND ----------

df.duplicated().sum()

# COMMAND ----------

df.drop_duplicates()

# COMMAND ----------

df["Price"]=df["Sales"]/df["Quantity"]
df["Total amount"]=df["Price"]*df["Quantity"]

# COMMAND ----------

df.head()

# COMMAND ----------

df.to_csv("/Workspace/Users/khushisingh.happy2001@gmail.com/Cleaned_Superstore.csv", index=False)