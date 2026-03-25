package com.shailesh.s3app.controller;

import com.shailesh.s3app.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/files")
public class S3Controller {
    @Autowired
    private S3Service s3Service;

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile file) throws IOException {
        return s3Service.uploadFile(file.getOriginalFilename(), file.getBytes());
    }

    @GetMapping("/download/{name}")
    public ResponseEntity<byte[]> download(@PathVariable String name) {
        byte[] data = s3Service.downloadFile(name);
        return ResponseEntity.ok()
                .header("Content-Disposition", "attachment; filename=\"" + name + "\"")
                .body(data);
    }

    @DeleteMapping("/delete/{name}")
    public String delete(@PathVariable String name) {
        return s3Service.deleteFile(name);
    }
    @GetMapping("/all")
    public List<String> getAllFiles() {
        return s3Service.listFiles();
    }
}
