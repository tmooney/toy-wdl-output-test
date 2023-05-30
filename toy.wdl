version 1.0

struct SampleStruct {
  String hi
  Int something
}

task toyTask {
    input {
        Int something
        String something_else
    }

    command {
        echo "hello world"
    }

    Map[String, String] sm = { "hello": "world", "something_else": something_else }
    SampleStruct so = object { hi: "everyone", something: something }

    output {
        Map[String, String] sample_map = sm
        SampleStruct sample_object = so
    }

    runtime {
        docker: "ubuntu:xenial"
        memory: "1GB"
    }
}

workflow toyWorkflow {
    input {
        Int something
        String something_else
    }
    call toyTask {
      input:
        something=something,
        something_else=something_else
    }
    output {
        Map[String, String] sample_map = toyTask.sample_map
        SampleStruct sample_object = toyTask.sample_object
    }
}
