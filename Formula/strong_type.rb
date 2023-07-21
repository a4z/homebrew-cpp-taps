class StrongType < Formula
  desc "Additive strong typedef library for C++14/17/20"
  homepage "https://github.com/rollbear/strong_type"
  url "https://github.com/rollbear/strong_type/archive/refs/tags/v12.tar.gz"
  sha256 "8af0400c7ae76c7ec8646e929bacb37fc7fcae33e54eeaa61fa9f9df508a9248"
  license "BSL-1.0"

  bottle do
    root_url "https://github.com/a4z/homebrew-cpp-taps/releases/download/strong_type-12"
    sha256 cellar: :any_skip_relocation, ventura:      "bb2e974803305302c8ab9e7d2ce739fff456a0cf21de0ce5a9cdd6a14e579473"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "336daadd94c6570d725ad4c1dd3cef7ca06d372f517275de7d82373bc4b4e1bc"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <strong_type/strong_type.hpp>
      int main() {
        strong::type<int, struct Tag> i{42};
        if (value_of(i) == 42)
          return 0;
        return 1;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++14", "-o", "test"
    system "./test"
  end
end
