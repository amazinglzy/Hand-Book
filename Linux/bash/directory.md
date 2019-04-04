# directory

列出目录的方法。

---

1. 使用 `ls -d` 

   ```sh
   ls -d */
   ```

2. 使用 `grep` 结合 `ls -F` 

   ```sh
   ls -F | grep "/$"
   ```

3. 使用 `grep` 结合 `ls -l`

   ```sh
   ls -l | grep "^d"
   ```

4. 使用 `find`

   ```sh
   find . -type d -maxdepth 1 -print
   ```

   ​