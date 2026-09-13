package com.basicweb.shop.config;

import com.basicweb.shop.entity.User;
import com.basicweb.shop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class DataSeeder implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void run(String... args) throws Exception {
        Optional<User> adminOpt = userRepository.findByEmail("admin@admin.com");
        if (!adminOpt.isPresent()) {
            User admin = new User();
            admin.setEmail("admin@admin.com");
            admin.setPassword("123456");
            admin.setFullName("Super Admin");
            admin.setRole("ADMIN");
            admin.setActive(true);
            userRepository.save(admin);
            System.out.println("Mock Admin user seeded successfully!");
        }
    }
}
