package com.basicweb.shop.controller;

import com.basicweb.shop.entity.Product;
import com.basicweb.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String home(Model model) {
        List<Product> latestProducts = productService.getTop10LatestProducts();
        model.addAttribute("products", latestProducts);
        return "home/index";
    }
}
