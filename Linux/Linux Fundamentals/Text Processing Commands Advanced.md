# Text Processing Commands — Extended

## Commands Overview 

| Command | Description | Example |
|-------------|-----------------|----------------|
| `grep`      | Search for patterns in files | `grep "ERROR" app.log` |
| `sed`       | Stream editor for filtering and transforming text | `sed 's/error/ERROR/g' file.txt` |
| `awk`       | Pattern scanning and processing language | | `awk '{print $1}' file.txt` |
| `cut`       | Remove sections from each line of files | `cut -d "," -f 2 data.csv` |
| `sort`      | Sort lines of text files | `sort file.txt` |
| `uniq`      | Report or filter out repeated lines | `sort file.txt | uniq` |
| `wc`        | Count lines, words, characters, bytes | `wc -l file.txt` |
| `tr`        | Translate or delete characters | `tr 'a-z' 'A-Z' < file.txt` |
| `paste`     | Merge lines of files | `paste file1.txt file2.txt` |
| `diff`      | Compare files line by line | `diff file1.txt file2.txt` |

---


## 1️⃣ grep — Pattern Searching

### Basic Search

```bash
grep "ERROR" app.log
```

### Case Insensitive

```bash
grep -i "error" app.log
```

### Show Line Numbers

```bash
grep -n "Exception" server.log
```

### Count Matches

```bash
grep -c "500" access.log
```

### Recursive Search

```bash
grep -r "TODO" .
```

### Match Whole Word

```bash
grep -w "cat" file.txt
```

### Invert Match

```bash
grep -v "DEBUG" app.log
```

### Extended Regex

```bash
grep -E "ERROR|WARNING" app.log
```

### Fixed String (No Regex)

```bash
grep -F "127.0.0.1" access.log
```

### Show Context

```bash
grep -A 3 "Exception" server.log
grep -B 2 "Exception" server.log
grep -C 2 "Exception" server.log
```

### Search Multiple Files

```bash
grep "ERROR" *.log
```

---

## 2️⃣ sed — Stream Editor

### Replace First Occurrence

```bash
sed 's/error/ERROR/' file.txt
```

### Replace All Occurrences

```bash
sed 's/error/ERROR/g' file.txt
```

### Edit File In-Place (Linux)

```bash
sed -i 's/localhost/127.0.0.1/g' config.txt
```

### Edit File In-Place (macOS)

```bash
sed -i '' 's/localhost/127.0.0.1/g' config.txt
```

### Delete Line by Number

```bash
sed '3d' file.txt
```

### Delete Lines by Pattern

```bash
sed '/ERROR/d' file.txt
```

### Delete Range of Lines

```bash
sed '3,6d' file.txt
```

### Insert Before Line

```bash
sed '2i NewLine' file.txt
```

### Append After Line

```bash
sed '2a NewLine' file.txt
```

### Replace Entire Line

```bash
sed '2c ReplacedLine' file.txt
```

### Print Matching Lines Only

```bash
sed -n '/ERROR/p' file.txt
```

---

## 3️⃣ awk — Structured Text Processing

### Print First Column

```bash
awk '{print $1}' file.txt
```

### Use Custom Delimiter

```bash
awk -F "," '{print $2}' data.csv
```

### Multiple Columns

```bash
awk '{print $1, $3}' file.txt
```

### Conditional Filtering

```bash
awk '$3 > 100' file.txt
```

### Match Exact Field

```bash
awk '$2 == "ERROR"' file.txt
```

### Print Line Number

```bash
awk '{print NR, $0}' file.txt
```

### Count Lines

```bash
awk 'END {print NR}' file.txt
```

### Sum Column

```bash
awk '{sum += $3} END {print sum}' file.txt
```

### Average Column

```bash
awk '{sum += $3} END {print sum/NR}' file.txt
```

### Change Output Separator

```bash
awk 'BEGIN {OFS=","} {print $1,$2}' file.txt
```

### BEGIN and END Blocks

```bash
awk 'BEGIN {print "Start"} {print $0} END {print "End"}' file.txt
```

---

## 4️⃣ cut — Column Extraction

### Extract Single Column

```bash
cut -d "," -f 2 data.csv
```

### Extract Multiple Columns

```bash
cut -d "," -f 1,3 data.csv
```

### Extract Range

```bash
cut -d "," -f 1-3 data.csv
```

### Extract Characters

```bash
cut -c 1-5 file.txt
```

### Exclude Column

```bash
cut -d "," -f 2 --complement data.csv
```

---

## 5️⃣ sort — Sorting

### Alphabetical

```bash
sort file.txt
```

### Numeric

```bash
sort -n numbers.txt
```

### Reverse

```bash
sort -r file.txt
```

### Numeric Reverse

```bash
sort -nr numbers.txt
```

### Sort by Column

```bash
sort -t "," -k2 data.csv
```

### Sort by Column Numerically

```bash
sort -t "," -k3 -n data.csv
```

### Unique Sort

```bash
sort -u file.txt
```

### Human Readable Sizes

```bash
ls -lh | sort -k5 -h
```

---

## 6️⃣ uniq

### Remove Duplicates

```bash
sort file.txt | uniq
```

### Count Occurrences

```bash
sort file.txt | uniq -c
```

### Show Duplicates Only

```bash
sort file.txt | uniq -d
```

### Show Unique Only

```bash
sort file.txt | uniq -u
```

---

## 7️⃣ wc

### Full Output

```bash
wc file.txt
```

### Line Count

```bash
wc -l file.txt
```

### Word Count

```bash
wc -w file.txt
```

### Character Count

```bash
wc -m file.txt
```

### Byte Count

```bash
wc -c file.txt
```

---

## 8️⃣ tr

### Lowercase to Uppercase

```bash
tr 'a-z' 'A-Z' < file.txt
```

### Delete Characters

```bash
tr -d ',' < file.txt
```

### Remove Spaces

```bash
tr -d ' ' < file.txt
```

### Squeeze Repeated Spaces

```bash
tr -s ' ' < file.txt
```

### Replace Characters

```bash
tr ':' ',' < file.txt
```

---

## 9️⃣ paste

### Merge Two Files

```bash
paste file1.txt file2.txt
```

### Custom Delimiter

```bash
paste -d "," file1.txt file2.txt
```

### Serial Paste

```bash
paste -s file.txt
```

---

## 🔟 diff

### Standard Diff

```bash
diff file1.txt file2.txt
```

### Unified Format

```bash
diff -u file1.txt file2.txt
```

### Side-by-Side

```bash
diff -y file1.txt file2.txt
```

### Recursive

```bash
diff -r dir1 dir2
```

---

## Real-World Pipelines

### Most Frequent IP

```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head
```

### Top 10 Largest Files

```bash
du -h . | sort -hr | head -10
```

### Count HTTP 500 Errors

```bash
grep " 500 " access.log | wc -l
```

### Extract Unique Status Codes

```bash
awk '{print $9}' access.log | sort -u
```

---

