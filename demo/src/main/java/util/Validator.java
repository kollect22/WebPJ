package util;

import java.util.regex.Pattern;

public class Validator {

    private static final String EMAIL_PATTERN =
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

    private static final String PHONE_PATTERN = "^0\\d{9}$";

    private static final String USERNAME_PATTERN = "^[a-zA-Z0-9._-]{3,50}$";

    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$";


    public static boolean isEmail(String email) {
        return Pattern.matches(EMAIL_PATTERN, email);
    }

    public static boolean isPhone(String phone) {
        return Pattern.matches(PHONE_PATTERN, phone);
    }

    public static boolean isValidUsername(String username) {
        return isEmail(username) || isPhone(username);
    }

    public static boolean isStrongPassword(String password) {
        return Pattern.matches(PASSWORD_PATTERN, password);
    }
}