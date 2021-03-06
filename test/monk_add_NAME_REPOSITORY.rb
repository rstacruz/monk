require File.expand_path("helper", File.dirname(__FILE__))

prepare do
  FileUtils.rm_rf(TARGET)
end

# monk add NAME REPOSITORY
scope do
  test "add the named repository to the configuration" do
    monk("add foobar http://github.com/monkrb/foo.git")
    out, _ = monk("show foobar")
    assert out["foobar"]
    assert out["http://github.com/monkrb/foo.git"]
    monk("rm foobar")
  end

  test "allow to fetch from the added repository with --skeleton parameter" do
    monk("add glue http://github.com/monkrb/glue.git")

    out, _ = monk("init #{TARGET} --skeleton glue")
    assert out.match(/Success!/)
  end

  test "allow to fetch from the added repository with the -s parameter" do
    monk("add glue http://github.com/monkrb/glue.git")

    out, _ = monk("init #{TARGET} -s glue")
    assert out.match(/Success!/)
  end
end
