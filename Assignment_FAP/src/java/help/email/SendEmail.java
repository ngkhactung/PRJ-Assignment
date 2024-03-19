/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package help.email;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.DataHandler;
/**
 *
 * @author Admin
 */
public class SendEmail {
    public static void sendEmailToStudent(String name){
        final String username = "tungnkhe170386@fpt.edu.vn";
        final String password = "osza qqhd nouu vhky";

        // Cài đặt thông số cấu hình cho mail server
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo một phiên mới của JavaMail API
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Tạo một email mới
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // Địa chỉ email người gửi
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("khactung1611@gmail.com")); // Địa chỉ email người nhận
            message.setSubject("Testing Subject");
            message.setText("Dear "+ name + "\n\n You are absent today");

            // Gửi email
            Transport.send(message);

            System.out.println("Email sent successfully.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
