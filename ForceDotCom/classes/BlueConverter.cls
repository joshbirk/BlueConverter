public with sharing class BlueConverter {
	//Data Variables
	public List<BlueCategory> blueData { get; set; }
	public String contentType {get; set;}
	public Boolean isDownload {get; set;}
	//Document Variables
	public Document document {
		get {
			if (document == null)
			document = new Document();
			return document;
		}
		set;
	}
	
	public String documentBody {
		get {
			if (document != null && document.body != null) {
				return document.body.toString();
			} else {
				return '';
			}
		}
	}
	
	public List<String> documentLines {get; set;}
	public String documentSize {
		get { 
			if(documentBody != '') {
				return String.valueOf(documentLines.size());
			} else {
				return '0';
			}
		}
	}
	
	public String dataJSON {
		get {
			return JSON.serializePretty(blueData);
		}
	}
	
	
	public BlueConverter() {
		blueData = new List<BlueCategory>();
		contentType = 'text/html';
		isDownload = false;
		
		if(ApexPages.currentPage().getParameters().get('id') != null) {
			Document documentOfRecord = [ SELECT Id, Body from Document WHERE ID = :ApexPages.currentPage().getParameters().get('id') ];
			document = new Document();
			document.body = documentOfRecord.body;
			isDownload = true;
			contentType = ApexPages.currentPage().getParameters().get('ct');
		}
	}
	
	public PageReference clearData() {
		Document documentOfRecord = [ SELECT Id, Body from Document WHERE ID = :ApexPages.currentPage().getParameters().get('id') ];
		delete documentOfRecord;
		return null;
	}
	
	public PageReference useSample() {
		PageReference p = new PageReference('/resource/1321301796000/BlueButtonSample');
		document = new Document();
		document.body = p.getContent();
		return upload();
	}

	
	public PageReference upload() {
		documentLines = documentBody.split('\n');
		BlueCategory currentCat;
		Boolean endTD = false;
		Boolean eoc = false;
		for(String line : documentLines) {
			line = line.replace('\r','');
			line = line.replace('\n','');
			if(line.startsWith('-')) {
				blueData.add(currentCat);
				String catName = line.replace('-','');
				if(catName != ' MY HEALTHEVET PERSONAL HEALTH INFORMATION ') {
					BlueCategory newCat = new BlueCategory(catName);
					currentCat = newCat;
				}
			} 
			if(line.indexOf(': ') > 0 && currentCat != null) {
				if(line.split(': ').size() > 1) {
					currentCat.addData(line.split(': ')[0], line.split(': ')[1], endTD, eoc);
					endTD = !endTD;
				}
			}
			
		}
		return null;
	}

}
