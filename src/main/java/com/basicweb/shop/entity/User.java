package com.basicweb.shop.entity;

import javax.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    @Column(nullable = false, unique = true)
    private String email;

    // @NotBlank(message = "Mật khẩu không được để trống")
    // @Size(min = 6, message = "Mật khẩu phải có ít nhất 6 ký tự")
    @Column(nullable = false)
    private String password;

    @NotBlank(message = "Họ tên không được để trống")
    private String fullName;

    private String phone;

    private String avatarUrl;

    @Builder.Default
    @Column(name = "is_active", nullable = false)
    private boolean active = false;

    @Builder.Default
    @Column(nullable = false, columnDefinition = "varchar(255) default 'USER'")
    private String role = "USER";

    private String otpCode;

    private LocalDateTime otpExpiryTime;
}
