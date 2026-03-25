package com.shailesh.s3app.controller;

import com.shailesh.s3app.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/files")
public class S3Controller {
    @Autowired
    private S3Service s3Service;

    @PostMapping("/upload")
    public String upload(@RequestParam String name, @RequestBody byte[] content) {
        return s3Service.uploadFile(name, content);
    }

    @GetMapping("/download/{name}")
    public byte[] download(@PathVariable String name) {
        return s3Service.downloadFile(name);
    }

    @DeleteMapping("/delete/{name}")
    public String delete(@PathVariable String name) {
        return s3Service.deleteFile(name);
    }
}
