package tags;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class LoteryResultTag extends SimpleTagSupport {

	private String[] numbers;
	List<Integer> fileNumbers = new ArrayList<>();
	List<Integer> coincidences = new ArrayList<>();

	public void setNumbers(String[] numbers) {
		this.numbers = numbers;
	}

	private String file;

	public void setFile(String file) {
		this.file = file;
	}

	@Override
	public void doTag() throws JspException, IOException {
		getNumbersFromFile();
		getJspContext().getOut().print(coincidencesCount());
	}

	private void getNumbersFromFile() {
		File result = new File(file);
		if (result.exists()) {
			try (BufferedReader bf = new BufferedReader(new FileReader(result));) {
				String line = bf.readLine();
				if (line != null) {
					String[] arNumbers = line.replace(" ", "").split(",");
					for (int i = 0; i < arNumbers.length; i++) {
						try {
							fileNumbers.add(Integer.parseInt(arNumbers[i]));
						} catch (NumberFormatException e) {
							// TODO: handle exception
						}
					}

				}
			} catch (IOException e) {
			}
		}
	}

	private int coincidencesCount() {

		if (numbers != null) {
			for (int i = 0; i < numbers.length; i++) {
				try {
					Integer reqNumber = Integer.parseInt(numbers[i]);
					if (fileNumbers.contains(reqNumber) && !coincidences.contains(reqNumber)) {
						coincidences.add(reqNumber);
					}
				} catch (NumberFormatException e) {
				}
			}
		}

		return coincidences.size();
	}

}
