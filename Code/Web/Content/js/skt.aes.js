/**
 * AES 加密（CBC 模式）
 * @param plaintext 明文
 * @param key 密钥
 * @param iv 偏移量
 */
function AES_CBC_ENCRYPT(plaintext) {
    const encrypted = CryptoJS.AES.encrypt(plaintext, CryptoJS.enc.Utf8.parse("1234567890123456"), {
        iv: CryptoJS.enc.Utf8.parse("1234567890123456"),
        mode: CryptoJS.mode.CBC, // 推荐使用 CBC，ECB 安全性较低
        padding: CryptoJS.pad.Pkcs7,
    })
    return encrypted.toString()
}
