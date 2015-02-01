package cn.martin.springmvc.admin.controller;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

/**
 * Created by 昌胜 on 2015-01-29.
 */

@Controller
public class ZipController {

	@RequestMapping(value = "/{pk}.zip/**")
	public void zip(HttpServletRequest request, @PathVariable String pk, HttpServletResponse response) {

		String root = request.getServletContext().getRealPath("/");

		String servletPath = request.getServletPath();

		try {
			ZipFile file = new ZipFile(root + File.separator + pk + ".zip");
			String path = StringUtils.replace(servletPath, "/" + pk + ".zip/", "");
			ZipArchiveEntry entry = file.getEntry(path);

			String ext = StringUtils.getFilenameExtension(path);
			if (ext.equals("css")) {
				response.setContentType("text/css");
			}else if(ext.equals("js")){
				response.setContentType("application/javascript");
			}else if(ext.equals("png")){
				response.setContentType("image/png");
			}
			
			IOUtils.copy(file.getInputStream(entry), response.getOutputStream());
			file.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// @ResponseStatus(HttpStatus.NOT_MODIFIED)

	}

	@PostConstruct
	public void init() {
		System.out.println("init");
	}
}
