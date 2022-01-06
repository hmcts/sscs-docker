import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.util.*;
import java.io.*;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import org.yaml.snakeyaml.*;

class ReplaceCallbackUrls {

    private final static List<String> sheetNames = Arrays.asList("CaseEvent", "CaseEventToFields");

    public static void main(String[] args) throws Exception {

        String excelFilePath = args[0];
        String urlsSwapFile = args[1];
        String host = args[2];

        try (FileInputStream inputStream = new FileInputStream(new File(excelFilePath))) {
            Workbook workbook = WorkbookFactory.create(inputStream);

            Yaml yaml = new Yaml();
            try (InputStream yamlInputStream = new FileInputStream(new File(urlsSwapFile))) {
                LinkedHashMap<String, Object> linkedHashMap = yaml.load(yamlInputStream);
                ArrayList urls = (ArrayList) linkedHashMap.get("urls");


                for (String sheetName : sheetNames) {
                    replaceUrlsInSheetName(urls, workbook, sheetName, host);
                }
            }
            try (FileOutputStream outputStream = new FileOutputStream(excelFilePath)) {
                workbook.write(outputStream);
                workbook.close();
            }
        }



    }

    private static void replaceUrlsInSheetName(ArrayList urls, Workbook workbook, String sheetName, String host) throws Exception {
        Sheet sheet = workbook.getSheet(sheetName);

        if (sheet == null) {
            throw new Exception("Cannot find " + sheetName + " sheet");
        }

        int rowCount = sheet.getLastRowNum();

        for (int i = 1; i <= rowCount; i++) {
            Row row = sheet.getRow(i);
            int cellCount = row.getLastCellNum();
            for (int j = 0; j < cellCount; j++) {
                Cell cell = row.getCell(j);
                if (cell != null) {
                    CellType cellType = cell.getCellType();
                    if (cellType == CellType.STRING) {
                        String value = cell.getStringCellValue();
                        if (value.contains("http")) {
                            for (int k = 0; k < urls.size(); k++) {
                                LinkedHashMap<String, Object> url = (LinkedHashMap) urls.get(k);
                                String from = (String) url.get("from");
                                String port = (String) url.get("to");
                                if (value.contains(from)) {
                                    String newTo = host + port.trim();
                                    String replaced = value.replace(from, newTo);
                                    System.out.println("Replacing " + value + " with " + replaced);
                                    cell.setCellValue(replaced);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}