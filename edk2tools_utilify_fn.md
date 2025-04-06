# Fix Edk2ToolsBuild.py not working

Modify the utility_functions.py `reader(...)` method at line 73 by :

```python
    line = stream.readline()
    try:
        s = line.decode(sys.stdout.encoding or "utf-8", errors=encodingErrors)
    except UnicodeDecodeError:
        s = line.decode("latin", errors=encodingErrors)
```