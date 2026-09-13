package com.basicweb.shop.controller;

import com.basicweb.shop.dto.ProfileRequest;
import com.basicweb.shop.entity.User;
import com.basicweb.shop.repository.UserRepository;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        ProfileRequest request = new ProfileRequest();
        request.setFullName(user.getFullName());
        request.setPhone(user.getPhone());
        
        model.addAttribute("profileRequest", request);
        return "user/profile";
    }

    @PostMapping("/update")
    public String updateProfile(@Valid @ModelAttribute("profileRequest") ProfileRequest request,
                                BindingResult bindingResult,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/login";
        }
        
        if (bindingResult.hasErrors()) {
            return "user/profile";
        }
        
        try {
            User user = userRepository.findById(sessionUser.getId()).orElseThrow();
            user.setFullName(request.getFullName());
            user.setPhone(request.getPhone());
            
            MultipartFile multipartFile = request.getAvatar();
            if (multipartFile != null && !multipartFile.isEmpty()) {
                String fileName = StringUtils.cleanPath(Objects.requireNonNull(multipartFile.getOriginalFilename()));
                user.setAvatarUrl("/uploads/" + fileName);
                
                String uploadDir = "uploads/";
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                try (InputStream inputStream = multipartFile.getInputStream()) {
                    Path filePath = uploadPath.resolve(fileName);
                    Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                } catch (IOException ioe) {
                    throw new IOException("Không thể lưu ảnh: " + fileName, ioe);
                }
            }
            
            userRepository.save(user);
            session.setAttribute("user", user); // update session
            redirectAttributes.addFlashAttribute("message", "Cập nhật profile thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        return "redirect:/profile";
    }
}
