import unittest
import os


def generate_results_files(first_file = "test.txt", second_file = "", flag = "", pattern = ""):
    os.system(f"grep {flag} {pattern} {first_file} {second_file} > original_result")
    os.system(f"./s21_grep {flag} {pattern} {first_file} {second_file} > custom_result")
    os.system("diff original_result custom_result > diff_result")


class GrepMainTest(unittest.TestCase):

    def test_one_file(self):
        generate_results_files(pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")

    def test_two_file(self):
        generate_results_files(second_file="test2.txt", pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_e_flag(self):
        generate_results_files(flag="-e", pattern="[a-z]") 

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")

    def test_i_flag(self):
        generate_results_files(flag="-i", pattern="WORD")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_v_flag(self):
        generate_results_files(flag="-v", pattern="WORD")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")

    def test_c_flag(self):
        generate_results_files(flag="-c", pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")

    def test_l_flag(self):
        generate_results_files(flag="-l", pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")

    def test_n_flag(self):
        generate_results_files(flag="-n", pattern="3")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_h_flag(self):
        generate_results_files(flag="-h", pattern="word", second_file="test2.txt")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_s_flag(self):
        generate_results_files(flag="-s", pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_f_flag(self):
        generate_results_files(flag="-f", first_file="regex.txt", second_file="test.txt")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")
    
    def test_o_flag(self):
        generate_results_files(flag="-o", pattern="word")

        self.assertEqual(os.path.getsize("diff_result"), 0, "Diff size should be 0")


if __name__ == "__main__":
    unittest.main()
