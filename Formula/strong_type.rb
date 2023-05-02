class StrongType < Formula
  desc "Additive strong typedef library for C++14/17/20"
  homepage "https://github.com/rollbear/strong_type"
  url "https://github.com/rollbear/strong_type/archive/refs/tags/v10.tar.gz"
  sha256 "154e4ceda6cf8fe734deb7eafdf58df5052822d04425dc7c22711ef54cdaeefa"
  license "BSL-1.0"

  bottle do
    root_url "https://github.com/a4z/homebrew-cpp-taps/releases/download/strong_type-10"
    rebuild 1
    sha256 cellar: :any_skip_relocation, all:          "b0d2114a201cd91de39c4ab9164069305053529e50bb05fd9c99676d6b5ec41e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "09cb48a817459dc9903a0aca65c8c0fd188c15fd36eddc18634a231acf71cc77"
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
