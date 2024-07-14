import csv
import random

def escape_prolog_string(s):
    return s.replace("'", "\\'")

def generate_budget(min_budget=4.0, max_budget=20.0):
    return round(random.uniform(min_budget, max_budget), 1)

def csv_to_prolog(input_file, output_file):
    with open(input_file, 'r', encoding='utf-8') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        
        with open(output_file, 'w', encoding='utf-8') as prolog_file:
            for row in csv_reader:
                identificador = row['rank']
                nome = escape_prolog_string(row['name'])
                ano = row['year']
                nota = row['rating']
                genero = row['genre']
                valor = generate_budget()
                disponivel = "true" 
                
                prolog_fact = f"filme({identificador}, '{nome}', {ano}, {nota}, '{genero}', {valor}, {disponivel}).\n"
                prolog_file.write(prolog_fact)

# Exemplo de uso
input_csv = 'IMDB Top 250 Movies.csv'
output_prolog = 'dataset.pl'
csv_to_prolog(input_csv, output_prolog)
