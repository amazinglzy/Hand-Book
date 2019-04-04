# java 操作 excel, xlsx, xlx

```java
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class Main {

    public static void main(String[] args) throws IOException, InvalidFormatException {
    // write your code here
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("sheet1");

        for (int row = 0; row < 10; row ++) {
            Row rows = sheet.createRow(row);
            for (int col = 0; col < 10; col ++) {
                rows.createCell(col).setCellValue("data" + row + col);
            }
        }

        File xlsFile = new File("output/poi.xlsx");
        FileOutputStream xlsStream = new FileOutputStream(xlsFile);
        workbook.write(xlsStream);
        xlsStream.close();

        Workbook readWorkBook = WorkbookFactory.create(xlsFile);
        int sheetCount = workbook.getNumberOfSheets();
        for (int i = 0; i < sheetCount; i++) {
            Sheet readSheet = readWorkBook.getSheetAt(i);
            int rows = sheet.getLastRowNum() + 1;
            Row tmp = sheet.getRow(0);
            if (tmp == null) {
                continue;
            }

            int cols = tmp.getPhysicalNumberOfCells();
            for (int row = 0; row < rows; row ++) {
                Row r = sheet.getRow(row);
                for (int col = 0; col < cols; col ++) {
                    System.out.printf("%10s", r.getCell(col).getStringCellValue());
                }
                System.out.println();
            }
        }
    }
}
```