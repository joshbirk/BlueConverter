public class BlueCategory {
	
	public String name {get; set;}
	public List<BlueKeyData> data {get; set;}
	
	
	public BlueCategory(String n) { 
		name = n; 
		data = new List<BlueKeyData>();
		}
		
	public void addData(String key, String value, Boolean endTD, Boolean eoc) {
		BlueKeyData bd = new BlueKeyData(key, value, endTD, eoc);
		data.add(bd);
	}

}
