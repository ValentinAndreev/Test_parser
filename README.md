# Test_parser

Установка:  
gem 'xmlparser', git: 'https://github.com/ValentinAndreev/Test_parser.git'  

Использовал libxml (по тестам быстрее остальных парсеров xml) и гем upsert (ActiveRecod - бутылочное горлышко при записи).  
xmlgenerator - генератор для тестирования, использование:  
require 'xmlgenerator' 
Xmlgenerator::Testgenerator.new.generate(number, table_name, node_name, filename)  
number - количество записей,  
table_name - корневой элемент,  
node_name - подэлемент,  
filename - имя файла, куда сохраняется xml.  
Пример (по заданию):
Xmlgenerator::Testgenerator.new.generate(300_000, 'visits', 'visit', 'sample.xml')  

xmlparser - сам парсер, использование:  
require 'xmlparser'  
Xmlparser::Parser.new.parse_file(db_name, db_table, file, elements)  
db_name - имя создаваяемой базы данных,  
db_table - имя создаваемой таблицы,  
file - xml файл для парсинга,  
elements - хэш со строковыми параметрами, соотвутствующими структуре файла.  
Пример (по заданию):
Xmlparser::Parser.new.parse_file('sample', 'visit', 'sample.xml', {'id' => 'integer', 'start_at' => 'timestamp', 'end_at' => 'timestamp', 'sum' => 'double precision'}))  

Замечания:  
Использовал postgresql (можно было бы добавить выбор базы в конфиге).  
