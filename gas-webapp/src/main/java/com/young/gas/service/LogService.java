package com.young.gas.service;

import java.util.List;
import com.young.gas.beans.Log;

public interface LogService {

	public boolean addLog(Log log);
	
	public List<Log> listLogs();
	
}
