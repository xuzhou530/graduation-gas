package tcp.util;

public class GeneralException extends RuntimeException {
	public GeneralException() {
		super();
	}
	
	public GeneralException(String message) {
		super(message);
	}
	
	public GeneralException(String message, Throwable cause) {
		super(message, cause);
	}
	
	public GeneralException(Throwable cause) {
		super(cause);
	}

	private static final long serialVersionUID = 2174655670701233591L;
}
