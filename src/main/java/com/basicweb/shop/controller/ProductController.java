package com.basicweb.shop.controller;

import com.basicweb.shop.entity.Product;
import com.basicweb.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/product")
    public String listProducts(Model model, @RequestParam(defaultValue = "0") int page) {
        Page<Product> productPage = productService.getProductsPaginated(page, 6);
        model.addAttribute("productPage", productPage);
        return "products/list";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        if (product != null) {
            model.addAttribute("product", product);
            return "products/detail";
        }
        return "redirect:/product";
    }
}
