# Vô hình học đường — triển khai chính thức

## Kiến trúc
- Vercel: hosting frontend và API serverless.
- Supabase: đăng ký/đăng nhập, PostgreSQL, Row Level Security.
- Google Gemini: Milo AI; API key chỉ lưu trong biến môi trường Vercel.

Đây là mã nguồn để bạn cấu hình và deploy, chưa phải website đã được xuất bản.

## 1. Supabase
1. Tạo project tại https://supabase.com.
2. Vào SQL Editor, chạy toàn bộ `supabase/schema.sql`.
3. Trong Project Settings → API, lấy Project URL và anon/public (hoặc publishable) key.
4. Authentication → URL Configuration: sau khi deploy, đặt Site URL là URL Vercel và thêm Redirect URL `https://TEN-DU-AN.vercel.app/**`. Bật Email provider.

## 2. Cấu hình frontend
Mở `config.js`, thay `https://YOUR-PROJECT.supabase.co` và `YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY` bằng URL và public key của Supabase. File này chỉ chứa public key; không được đặt Gemini key hay service_role key vào đây.

## 3. Gemini
Tạo API key tại https://aistudio.google.com/app/apikey. Không gửi key qua chat và không commit lên GitHub.

## 4. GitHub
Tạo repository mới, giải nén ZIP và upload toàn bộ file. Đảm bảo `config.js` đã được điền thông tin Supabase public. Không upload secret, file .env, Gemini key hoặc service_role key.

## 5. Vercel
1. Đăng nhập https://vercel.com bằng GitHub → Add New → Project → import repository.
2. Framework preset chọn Other; Build Command và Output Directory để trống.
3. Settings → Environment Variables, thêm:
   - `SUPABASE_URL` = Project URL
   - `SUPABASE_ANON_KEY` = public anon/publishable key
   - `GEMINI_API_KEY` = key Google AI Studio
4. Deploy. Sau khi có URL Vercel, quay lại Supabase cập nhật Site URL và Redirect URLs.

## 6. Kiểm thử
Tạo tài khoản test; xác nhận email; đăng nhập/đăng xuất; tạo check-in và nhật ký; thử xóa nhật ký; dùng hai tài khoản riêng để xác nhận không đọc chéo dữ liệu; thử Milo trên điện thoại và máy tính.

## Bảo vệ học sinh và dữ liệu
Website hướng đến học sinh. Trước khi đưa vào sử dụng thật, cần người lớn/nhà trường rà soát điều khoản dịch vụ, độ tuổi, yêu cầu đồng ý của phụ huynh/người giám hộ, thông báo quyền riêng tư, quy trình hỗ trợ khẩn cấp và quy định bảo vệ dữ liệu cá nhân. Không thu thập thông tin nhận dạng nếu không cần. Nội dung chat được gửi đến Google Gemini để tạo phản hồi; chat không lưu trong database. Milo không phải chuyên gia, không chẩn đoán. Check-in/nhật ký là dữ liệu riêng tư; cần kiểm thử RLS trước khi mời người dùng. Bộ mã nguồn này chưa được kiểm toán bảo mật; cần bổ sung rate limiting, quy trình xóa tài khoản/dữ liệu, backup và rà soát pháp lý trước khi mở rộng.
