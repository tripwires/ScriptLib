# Remove Lines

Removes every line from an input text file that contains any phrase listed in a phrases file.

```powershell
.\Remove-Lines.ps1 -InputFile .\input.txt -PhrasesFile .\phrases-to-remove.txt -OutputFile .\output.txt
```

Omit `-OutputFile` to replace the input file in place:

```powershell
.\Remove-Lines.ps1 -InputFile .\input.txt -PhrasesFile .\phrases-to-remove.txt
```

Add one phrase per line to `phrases-to-remove.txt`.
