# Session 10 - Ex3: Multi-stage Build & Layer Caching

Tối ưu dung lượng Docker Image của backend Node.js bằng kỹ thuật Multi-stage Build.

## Bảng so sánh

| Tiêu chí           | hw-backend:single | hw-backend:multistage |
|--------------------|-------------------|-----------------------|
| Base runtime       | node:18           | node:18-alpine        |
| Dung lượng (SIZE)  | 1.57 GB           | 185 MB                |
| Số lượng Layer     | <single>          | <multi>               |
| % giảm dung lượng  | -                 | ~88%                  |

## Nhận xét
- Multi-stage dùng image runtime siêu nhẹ (alpine) nên dung lượng giảm ~88%.
- Chỉ thị `COPY --from=builder` chỉ lấy sản phẩm cần (node_modules, server.js),
  loại bỏ toàn bộ công cụ build nặng của node:18.
- Layer Caching: copy `package*.json` trước giúp tận dụng cache khi code thay đổi,
  không phải cài lại dependencies mỗi lần build.

## Cách chạy
\`\`\`bash
docker build -f Dockerfile -t hw-backend:multistage .
docker run -d --name app-ex3 -p 8081:3000 hw-backend:multistage
curl -i http://localhost:8081/
\`\`\`
