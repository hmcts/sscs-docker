import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

/**
 * This program illustrates how to update an existing Microsoft Excel document.
 * Append new rows to an existing sheet.
 *
 * @author www.codejava.net
 *
 */
public class ReplaceCallbackUrls {

    private final static String sheetName = "CaseEvent";

    public static void main(String[] args) throws Exception {
        String excelFilePath = args[0];

        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        Workbook workbook = WorkbookFactory.create(inputStream);

        Sheet sheet = workbook.getSheet(sheetName);

        if (sheet == null) {
            throw new Exception("Cannot find " + sheetName + " sheet");
        }

        Object[][] bookData = {
                {"The Passionate Programmer", "Chad Fowler", 16},
                {"Software Craftmanship", "Pete McBreen", 26},
                {"The Art of Agile Development", "James Shore", 32},
                {"Continuous Delivery", "Jez Humble", 41},
        };

        int rowCount = sheet.getLastRowNum();

        for (Object[] aBook : bookData) {
            System.out.println("Creating row " + (rowCount + 1));
            Row row = sheet.createRow(++rowCount);

            int columnCount = 0;

            Cell cell = row.createCell(columnCount);
            cell.setCellValue(rowCount);

            for (Object field : aBook) {
                cell = row.createCell(++columnCount);
                if (field instanceof String) {
                    cell.setCellValue((String) field);
                } else if (field instanceof Integer) {
                    cell.setCellValue((Integer) field);
                }
            }

        }

        inputStream.close();

        FileOutputStream outputStream = new FileOutputStream(excelFilePath);
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();

    }

}