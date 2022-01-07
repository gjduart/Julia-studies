using BenchmarkTools
using DataFrames
using DelimitedFiles
using CSV
using XLSX
using Downloads

P = Downloads.download("https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv",
    "programming_languages.csv")

#A questão principal aqui é carregar dados de arquivos como arquivos csv, arquivos xlsx ou apenas arquivos de texto bruto. Veremos alguns pacotes do Julia que nos permitirão ler esses arquivos com muita facilidade.
# Vamos começar com o pacote DelimitedFiles que está na biblioteca padrão.
P,H =  readdlm("programming_languages.csv",',';header=true);

P
H


#Escrevendo em um doc txt
writedlm("programminglanguages_dlm.txt", P, '-')

#Lendo um CSV e Atribuindo a uma variavel como um DataFrame
C = CSV.read("programming_languages.csv", DataFrame)

#Visualizando o Tipo da Variavel C, para verificar se é mesmo um DataFrame
@show typeof(C)

#Visualizando DataFrame
C[1:10,:]

#Visualizando uma matrix
@show typeof(P)
P[1:10,:]

names(C)

C.year
C.language

describe(C)

@btime P,H = readdlm("programming_languages.csv",',';header=true)
@btime C = CSV.read("programming_languages.csv", DataFrame)

# Para escrever um arquivo CSV
CSV.write("programminglanguages_CSV.csv", DataFrame(P, :auto))

#Lendo um XLSX
T = XLSX.readdata("zillow_data_download_april2020.xlsx", #file name
    "Sale_counts_city", #sheet name
    "A1:F9" #cell range
    )

#Se você não quiser especificar intervalos de células ... embora isso demore um pouco mais ...
G = XLSX.readtable("zillow_data_download_april2020.xlsx","Sale_counts_city");

#Armazenando em um DataFrame
D = DataFrame(G...)

foods = ["Pizza","Apple", "Hamburguer","Banana"]
calories = [105, 47, 22, 105]
prices = [0.85, 1.6 , 0.8, 0.6,]

dataframe_calories =  DataFrame(item=foods,calories = calories)
dataframe_prices = DataFrame(item=foods, prices = prices)

DF = innerjoin(dataframe_calories,dataframe_prices, on=:item)

DataFrame(T, :auto)
