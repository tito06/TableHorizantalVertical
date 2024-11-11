package com.example.my_reports

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.provider.MediaStore
import android.content.ContentValues
import android.os.Environment
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.OutputStream

class MainActivity: FlutterActivity(){
private val CHANNEL = "com.example.my_reports/files"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "saveToDownloads") {
                val pdfBytes = call.argument<ByteArray>("pdfBytes")
                if (pdfBytes != null) {
                    saveToDownloads(pdfBytes)
                    result.success("PDF saved successfully!")
                } else {
                    result.error("ERROR", "No PDF data", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    // Method to save the PDF to Downloads folder
    private fun saveToDownloads(pdfBytes: ByteArray) {
    try {
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, "downloaded_report.pdf")
            put(MediaStore.MediaColumns.MIME_TYPE, "application/pdf")
            put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
        }
        val resolver = contentResolver
        val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)

        if (uri != null) {
            val outputStream: OutputStream? = resolver.openOutputStream(uri)
            outputStream?.write(pdfBytes)
            outputStream?.close()
            Log.d("MainActivity", "PDF saved successfully to Downloads folder")
        } else {
            Log.e("MainActivity", "Failed to create file URI")
        }
    } catch (e: IOException) {
        Log.e("MainActivity", "Error saving PDF: ${e.message}")
    }
}
}