package com.basicweb.shop.controller;

import com.basicweb.shop.entity.User;
import com.basicweb.shop.service.UserService;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       Model model, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login"; 
        
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<User> userPage = userService.getUsersWithPagination(keyword, pageable);
        
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("keyword", keyword);
        return "admin/user/list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login";
        model.addAttribute("userObj", new User());
        return "admin/user/form";
    }

    @PostMapping("/create")
    public String createUser(@ModelAttribute("userObj") User userObj, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login";
        userService.saveUser(userObj);
        return "redirect:/admin/user";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login";
        User user = userService.getUserById(id);
        model.addAttribute("userObj", user);
        return "admin/user/form";
    }

    @PostMapping("/edit/{id}")
    public String editUser(@PathVariable Long id, @ModelAttribute("userObj") User userObj, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login";
        User existing = userService.getUserById(id);
        if (existing != null) {
            existing.setFullName(userObj.getFullName());
            existing.setEmail(userObj.getEmail());
            existing.setPhone(userObj.getPhone());
            existing.setActive(userObj.isActive());
            existing.setRole(userObj.getRole());
            // Avoid overwriting password blindly in a real app, but simplified for CRUD
            userService.saveUser(existing);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null || !"ADMIN".equals(sessionUser.getRole())) return "redirect:/login";
        userService.deleteUser(id);
        return "redirect:/admin/user";
    }
}
