#the simplest possible job
SIMPLE_JOB = {'encoding_job' => {
    "encodings" => [
      {
        "destination_url" => "SOME_URL - ftp/s3",
      }
    ],
    "src" => "SOME_URL - http/https/ftp/s3"
  }
}

#a job with a manifest that only rotates the video
ROTATION_MANIFEST = {'encoding_job' => {
    "encodings" => [
      {
        "destination_url" => "SOME_URL - ftp/s3",
      }
    ],
    "manifest" => {
      "version" => 2,
      "tracks" => [{
        "clips" => [{
          "src" => "SOME_URL - http/https/ftp/s3",
          "media" => "video",
          "rotation" => 90
        }]
      }]
    }
  }
}

HD_ENCODE = {'encoding_job' => {
    "encodings" => [
      {
        "destination_url" => "SOME_URL - ftp/s3",
        "format" => "web_video",
        "preset" => "hd"
      },
      {
        "destination_url" => "SOME_URL - ftp/s3",
        "format" => "web_video",
        "preset" => "standard_definition"
      }
    ],
    "src" => "SOME_URL - http/https/ftp/s3"
  }
}
