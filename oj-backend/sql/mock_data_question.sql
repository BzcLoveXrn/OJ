-- 插入伪造数据的SQL
-- 先设置一个变量表示要插入的用户ID，方便后续删除

-- 插入50条编程题目数据
INSERT INTO question (title, content, tags, answer, submitNum, acceptedNum, judgeCase, judgeConfig, thumbNum, favourNum, userId, createTime)
VALUES
-- 算法题
('两数之和', '给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那两个整数，并返回他们的数组下标。', '["算法", "数组", "哈希表", "简单"]',
 '```java\npublic int[] twoSum(int[] nums, int target) {\n    Map<Integer, Integer> map = new HashMap<>();\n    for (int i = 0; i < nums.length; i++) {\n        int complement = target - nums[i];\n        if (map.containsKey(complement)) {\n            return new int[] { map.get(complement), i };\n        }\n        map.put(nums[i], i);\n    }\n    throw new IllegalArgumentException("No two sum solution");\n}\n```',
 5782, 3291,
 '[{"input": "[2,7,11,15]\\n9", "output": "[0,1]"}, {"input": "[3,2,4]\\n6", "output": "[1,2]"}, {"input": "[3,3]\\n6", "output": "[0,1]"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 894, 721, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)),

('合并两个有序链表', '将两个升序链表合并为一个新的升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。', '["算法", "链表", "递归", "简单"]',
 '```java\npublic ListNode mergeTwoLists(ListNode l1, ListNode l2) {\n    if (l1 == null) {\n        return l2;\n    } else if (l2 == null) {\n        return l1;\n    } else if (l1.val < l2.val) {\n        l1.next = mergeTwoLists(l1.next, l2);\n        return l1;\n    } else {\n        l2.next = mergeTwoLists(l1, l2.next);\n        return l2;\n    }\n}\n```',
 4213, 3089,
 '[{"input": "[1,2,4]\\n[1,3,4]", "output": "[1,1,2,3,4,4]"}, {"input": "[]\\n[]", "output": "[]"}, {"input": "[]\\n[0]", "output": "[0]"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 723, 556, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 300) DAY)),

('最长回文子串', '给定一个字符串 s，找到 s 中最长的回文子串。', '["算法", "字符串", "动态规划", "中等"]',
 '```python\ndef longestPalindrome(s):\n    if not s:\n        return ""\n    start = 0\n    max_len = 1\n    for i in range(len(s)):\n        # 偶数长度回文串\n        l, r = i, i+1\n        while l >= 0 and r < len(s) and s[l] == s[r]:\n            if r - l + 1 > max_len:\n                max_len = r - l + 1\n                start = l\n            l -= 1\n            r += 1\n        # 奇数长度回文串\n        l, r = i-1, i+1\n        while l >= 0 and r < len(s) and s[l] == s[r]:\n            if r - l + 1 > max_len:\n                max_len = r - l + 1\n                start = l\n            l -= 1\n            r += 1\n    return s[start:start+max_len]\n```',
 3845, 2132,
 '[{"input": "babad", "output": "bab"}, {"input": "cbbd", "output": "bb"}, {"input": "a", "output": "a"}, {"input": "ac", "output": "a"}]',
 '{"timeLimit": 2000, "memoryLimit": 256, "stackLimit": 128}',
 634, 492, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 270) DAY)),

('无重复字符的最长子串', '给定一个字符串，请你找出其中不含有重复字符的最长子串的长度。', '["算法", "哈希表", "字符串", "滑动窗口", "中等"]',
 '```javascript\nvar lengthOfLongestSubstring = function(s) {\n    let charMap = new Map();\n    let maxLen = 0;\n    let left = 0;\n    \n    for (let right = 0; right < s.length; right++) {\n        if (charMap.has(s[right])) {\n            left = Math.max(left, charMap.get(s[right]) + 1);\n        }\n        charMap.set(s[right], right);\n        maxLen = Math.max(maxLen, right - left + 1);\n    }\n    \n    return maxLen;\n};\n```',
 4932, 2734,
 '[{"input": "abcabcbb", "output": "3"}, {"input": "bbbbb", "output": "1"}, {"input": "pwwkew", "output": "3"}, {"input": "", "output": "0"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 812, 645, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 320) DAY)),

('路径总和', '给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。', '["算法", "树", "深度优先搜索", "简单"]',
 '```java\npublic boolean hasPathSum(TreeNode root, int sum) {\n    if (root == null) {\n        return false;\n    }\n    if (root.left == null && root.right == null) {\n        return sum == root.val;\n    }\n    return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val);\n}\n```',
 2845, 1932,
 '[{"input": "[5,4,8,11,null,13,4,7,2,null,null,null,1]\\n22", "output": "true"}, {"input": "[1,2,3]\\n5", "output": "false"}, {"input": "[1,2]\\n1", "output": "false"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 432, 321, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 250) DAY)),

-- 数据结构题
('实现栈', '使用数组或链表实现一个基本的栈数据结构，包含push、pop、top和getMin操作，要求所有操作的时间复杂度为O(1)。', '["数据结构", "栈", "设计", "中等"]',
 '```java\nclass MinStack {\n    private Stack<Integer> stack;\n    private Stack<Integer> minStack;\n\n    public MinStack() {\n        stack = new Stack<>();\n        minStack = new Stack<>();\n    }\n    \n    public void push(int val) {\n        stack.push(val);\n        if (minStack.isEmpty() || val <= minStack.peek()) {\n            minStack.push(val);\n        }\n    }\n    \n    public void pop() {\n        if (stack.pop().equals(minStack.peek())) {\n            minStack.pop();\n        }\n    }\n    \n    public int top() {\n        return stack.peek();\n    }\n    \n    public int getMin() {\n        return minStack.peek();\n    }\n}\n```',
 3214, 2241,
 '[{"input": "["MinStack","push","push","push","getMin","pop","top","getMin"]\\n[[],[-2],[0],[-3],[],[],[],[]]", "output": "[null,null,null,null,-3,null,0,-2]"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 593, 476, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY)),

('LRU缓存机制', '设计和实现一个 LRU (最近最少使用) 缓存机制。它应该支持以下操作：获取数据 get 和 写入数据 put。', '["数据结构", "设计", "哈希表", "链表", "困难"]',
 '```python\nclass LRUCache:\n    def __init__(self, capacity: int):\n        self.capacity = capacity\n        self.cache = {}\n        self.order = []\n\n    def get(self, key: int) -> int:\n        if key in self.cache:\n            self.order.remove(key)\n            self.order.append(key)\n            return self.cache[key]\n        return -1\n\n    def put(self, key: int, value: int) -> None:\n        if key in self.cache:\n            self.order.remove(key)\n        elif len(self.cache) >= self.capacity:\n            oldest = self.order.pop(0)\n            del self.cache[oldest]\n        self.cache[key] = value\n        self.order.append(key)\n```',
 4325, 1983,
 '[{"input": "["LRUCache","put","put","get","put","get","put","get","get","get"]\\n[[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]", "output": "[null,null,null,1,null,-1,null,-1,3,4]"}]',
 '{"timeLimit": 2000, "memoryLimit": 256, "stackLimit": 128}',
 982, 743, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 290) DAY)),

('二叉树的层序遍历', '给你一个二叉树，请你返回其按层序遍历得到的节点值。即逐层地，从左到右访问所有节点。', '["数据结构", "树", "广度优先搜索", "二叉树", "中等"]',
 '```cpp\nvector<vector<int>> levelOrder(TreeNode* root) {\n    vector<vector<int>> result;\n    if (!root) return result;\n    \n    queue<TreeNode*> q;\n    q.push(root);\n    \n    while (!q.empty()) {\n        int size = q.size();\n        vector<int> currentLevel;\n        \n        for (int i = 0; i < size; i++) {\n            TreeNode* node = q.front();\n            q.pop();\n            \n            currentLevel.push_back(node->val);\n            \n            if (node->left) q.push(node->left);\n            if (node->right) q.push(node->right);\n        }\n        \n        result.push_back(currentLevel);\n    }\n    \n    return result;\n}\n```',
 3456, 2789,
 '[{"input": "[3,9,20,null,null,15,7]", "output": "[[3],[9,20],[15,7]]"}, {"input": "[1]", "output": "[[1]]"}, {"input": "[]", "output": "[]"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 678, 543, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 210) DAY)),

-- Web开发题
('实现简单的RESTful API', '使用Node.js和Express框架实现一个简单的RESTful API，包含对用户资源的CRUD操作。', '["Web开发", "Node.js", "Express", "RESTful", "中等"]',
 '```javascript\nconst express = require(\'express\');\nconst app = express();\napp.use(express.json());\n\nlet users = [];\nlet nextId = 1;\n\n// 获取所有用户\napp.get(\'/api/users\', (req, res) => {\n    res.json(users);\n});\n\n// 获取单个用户\napp.get(\'/api/users/:id\', (req, res) => {\n    const user = users.find(u => u.id === parseInt(req.params.id));\n    if (!user) return res.status(404).json({ message: \'User not found\' });\n    res.json(user);\n});\n\n// 创建用户\napp.post(\'/api/users\', (req, res) => {\n    const user = {\n        id: nextId++,\n        name: req.body.name,\n        email: req.body.email\n    };\n    users.push(user);\n    res.status(201).json(user);\n});\n\n// 更新用户\napp.put(\'/api/users/:id\', (req, res) => {\n    const user = users.find(u => u.id === parseInt(req.params.id));\n    if (!user) return res.status(404).json({ message: \'User not found\' });\n    \n    user.name = req.body.name || user.name;\n    user.email = req.body.email || user.email;\n    \n    res.json(user);\n});\n\n// 删除用户\napp.delete(\'/api/users/:id\', (req, res) => {\n    const userIndex = users.findIndex(u => u.id === parseInt(req.params.id));\n    if (userIndex === -1) return res.status(404).json({ message: \'User not found\' });\n    \n    const deletedUser = users.splice(userIndex, 1);\n    res.json(deletedUser[0]);\n});\n\nconst PORT = process.env.PORT || 3000;\napp.listen(PORT, () => console.log(`Server running on port ${PORT}`));\n```',
 2987, 2145,
 '[{"input": "GET /api/users", "output": "[]"}, {"input": "POST /api/users {\"name\":\"John\",\"email\":\"john@example.com\"}", "output": "{\"id\":1,\"name\":\"John\",\"email\":\"john@example.com\"}"}]',
 '{"timeLimit": 3000, "memoryLimit": 512, "stackLimit": 256}',
 876, 731, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 175) DAY)),

('CSS网格布局实现', '使用CSS Grid布局实现一个响应式的图片画廊，在大屏幕上显示3列，中等屏幕显示2列，小屏幕显示1列。', '["Web开发", "CSS", "响应式设计", "前端", "简单"]',
 '```html\n<!DOCTYPE html>\n<html lang="en">\n<head>\n    <meta charset="UTF-8">\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n    <title>响应式图片画廊</title>\n    <style>\n        .gallery {\n            display: grid;\n            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));\n            grid-gap: 20px;\n            padding: 20px;\n        }\n        \n        .gallery-item img {\n            width: 100%;\n            height: auto;\n            object-fit: cover;\n            border-radius: 5px;\n        }\n        \n        @media (max-width: 768px) {\n            .gallery {\n                grid-template-columns: repeat(2, 1fr);\n            }\n        }\n        \n        @media (max-width: 480px) {\n            .gallery {\n                grid-template-columns: 1fr;\n            }\n        }\n    </style>\n</head>\n<body>\n    <div class="gallery">\n        <div class="gallery-item">\n            <img src="image1.jpg" alt="Image 1">\n        </div>\n        <div class="gallery-item">\n            <img src="image2.jpg" alt="Image 2">\n        </div>\n        <div class="gallery-item">\n            <img src="image3.jpg" alt="Image 3">\n        </div>\n        <!-- 添加更多图片 -->\n    </div>\n</body>\n</html>\n```',
 2145, 1987,
 '[{"input": "viewport width: 1200px", "output": "3 columns"}, {"input": "viewport width: 600px", "output": "2 columns"}, {"input": "viewport width: 400px", "output": "1 column"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 543, 478, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 150) DAY)),

('React计数器组件', '实现一个React计数器组件，包含增加、减少和重置按钮，以及当前计数显示。', '["Web开发", "React", "JavaScript", "前端", "简单"]',
 '```jsx\nimport React, { useState } from \'react\';\n\nfunction Counter() {\n  const [count, setCount] = useState(0);\n\n  const increment = () => {\n    setCount(prevCount => prevCount + 1);\n  };\n\n  const decrement = () => {\n    setCount(prevCount => prevCount - 1);\n  };\n\n  const reset = () => {\n    setCount(0);\n  };\n\n  return (\n    <div className="counter">\n      <h2>Counter: {count}</h2>\n      <div className="buttons">\n        <button onClick={decrement}>-</button>\n        <button onClick={reset}>Reset</button>\n        <button onClick={increment}>+</button>\n      </div>\n    </div>\n  );\n}\n\nexport default Counter;\n```',
 3214, 2983,
 '[{"input": "Initial render", "output": "Counter: 0"}, {"input": "Click + button", "output": "Counter: 1"}, {"input": "Click - button twice", "output": "Counter: -1"}, {"input": "Click Reset button", "output": "Counter: 0"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 721, 634, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 200) DAY)),

-- 数据库题
('SQL多表联查', '编写一个SQL查询，获取每个部门中薪资最高的员工信息，包括部门名称、员工姓名和薪资。', '["数据库", "SQL", "联表查询", "子查询", "中等"]',
 '```sql\nSELECT d.DepartmentName, e.EmployeeName, e.Salary\nFROM Employee e\nJOIN Department d ON e.DepartmentId = d.Id\nWHERE (e.DepartmentId, e.Salary) IN (\n    SELECT DepartmentId, MAX(Salary)\n    FROM Employee\n    GROUP BY DepartmentId\n);\n```',
 2874, 1856,
 '[{"input": "Employee表:\n| Id | EmployeeName | Salary | DepartmentId |\n|----|--------------|--------|---------------|\n| 1  | Joe          | 70000  | 1             |\n| 2  | Jim          | 90000  | 1             |\n| 3  | Henry        | 80000  | 2             |\n| 4  | Sam          | 60000  | 2             |\n| 5  | Max          | 90000  | 1             |\n\nDepartment表:\n| Id | DepartmentName |\n|----|----------------|\n| 1  | IT             |\n| 2  | Sales          |", "output": "| DepartmentName | EmployeeName | Salary |\n|----------------|--------------|--------|\n| IT             | Jim          | 90000  |\n| IT             | Max          | 90000  |\n| Sales          | Henry        | 80000  |"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 512, 436, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 230) DAY)),

('MySQL索引优化', '分析以下SQL查询并添加适当的索引以提高查询性能。', '["数据库", "MySQL", "索引", "性能优化", "中等"]',
 '```sql\n-- 原始表结构\nCREATE TABLE orders (\n    id INT PRIMARY KEY,\n    customer_id INT,\n    order_date DATE,\n    status VARCHAR(20),\n    amount DECIMAL(10,2)\n);\n\n-- 经常执行的查询\nSELECT * FROM orders\nWHERE customer_id = 123\nAND order_date BETWEEN \'2023-01-01\' AND \'2023-12-31\'\nORDER BY order_date DESC;\n\n-- 创建复合索引来优化查询\nCREATE INDEX idx_customer_date ON orders(customer_id, order_date);\n```',
 1945, 1324,
 '[{"input": "orders表有百万级数据，需要优化上述查询", "output": "创建复合索引: CREATE INDEX idx_customer_date ON orders(customer_id, order_date);"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 423, 345, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 185) DAY)),

-- 系统设计题
('设计一个短URL服务', '设计并实现一个短URL服务，将长URL转换为短URL，并能够通过短URL重定向到原始长URL。', '["系统设计", "哈希", "数据库", "Web服务", "困难"]',
 '```java\npublic class UrlShortener {\n    private HashMap<String, String> shortToLong = new HashMap<>();\n    private HashMap<String, String> longToShort = new HashMap<>();\n    private static final String CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";\n    private static final int BASE = CHARS.length();\n    private int counter = 0;\n    \n    // 编码函数：将数字转为短URL的编码\n    private String encode(int num) {\n        StringBuilder sb = new StringBuilder();\n        while (num > 0) {\n            sb.append(CHARS.charAt(num % BASE));\n            num /= BASE;\n        }\n        while (sb.length() < 6) {\n            sb.append(\'a\');\n        }\n        return sb.reverse().toString();\n    }\n    \n    // 生成短URL\n    public String shorten(String longUrl) {\n        if (longToShort.containsKey(longUrl)) {\n            return "http://tinyurl.com/" + longToShort.get(longUrl);\n        }\n        \n        String shortUrl = encode(counter++);\n        longToShort.put(longUrl, shortUrl);\n        shortToLong.put(shortUrl, longUrl);\n        \n        return "http://tinyurl.com/" + shortUrl;\n    }\n    \n    // 从短URL获取长URL\n    public String restore(String shortUrl) {\n        String key = shortUrl.replace("http://tinyurl.com/", "");\n        return shortToLong.getOrDefault(key, "");\n    }\n}\n```',
 2314, 1263,
 '[{"input": "shorten(\"https://www.example.com/very/long/url/that/needs/shortening\")", "output": "http://tinyurl.com/aaaaaa"}, {"input": "restore(\"http://tinyurl.com/aaaaaa\")", "output": "https://www.example.com/very/long/url/that/needs/shortening"}]',
 '{"timeLimit": 2000, "memoryLimit": 256, "stackLimit": 128}',
 783, 621, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 260) DAY)),

('设计一个简单的缓存系统', '设计一个内存缓存系统，支持设置过期时间、获取和删除操作。', '["系统设计", "缓存", "数据结构", "中等"]',
 '```python\nimport time\n\nclass SimpleCache:\n    def __init__(self):\n        self.cache = {}\n        \n    def set(self, key, value, ttl=None):\n        expiry = None\n        if ttl is not None:\n            expiry = time.time() + ttl\n        self.cache[key] = (value, expiry)\n        \n    def get(self, key):\n        if key not in self.cache:\n            return None\n        \n        value, expiry = self.cache[key]\n        if expiry is not None and time.time() > expiry:\n            del self.cache[key]\n            return None\n        \n        return value\n        \n    def delete(self, key):\n        if key in self.cache:\n            del self.cache[key]\n            return True\n        return False\n```',
 3125, 2341,
 '[{"input": "set(\"user1\", {\"name\": \"John\"}, 60)", "output": "null"}, {"input": "get(\"user1\")", "output": "{\"name\": \"John\"}"}]',
 '{"timeLimit": 1000, "memoryLimit": 256, "stackLimit": 128}',
 542, 467, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 240) DAY)),

-- 更多简单算法题
('反转字符串', '编写一个函数，其作用是将输入的字符串反转过来。', '["算法", "字符串", "双指针", "简单"]',
 '```python\ndef reverseString(s):\n    """    \n    :type s: List[str]\n    :rtype: None Do not return anything, modify s in-place instead.\n    """\n    left, right = 0, len(s) - 1\n    while left < right:\n        s[left], s[right] = s[right], s[left]\n        left += 1\n        right -= 1\n```',
 5123, 4897,
 '[{"input": "[\"h\",\"e\",\"l\",\"l\",\"o\"]", "output": "[\"o\",\"l\",\"l\",\"e\",\"h\"]"}, {"input": "[\"H\",\"a\",\"n\",\"n\",\"a\",\"h\"]", "output": "[\"h\",\"a\",\"n\",\"n\",\"a\",\"H\"]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 231, 207, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 120) DAY)),

('回文数', '判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。', '["算法", "数学", "简单"]',
 '```java\npublic boolean isPalindrome(int x) {\n    if (x < 0) return false;\n    if (x < 10) return true;\n    if (x % 10 == 0 && x != 0) return false;\n    \n    int revertedNumber = 0;\n    while (x > revertedNumber) {\n        revertedNumber = revertedNumber * 10 + x % 10;\n        x /= 10;\n    }\n    \n    return x == revertedNumber || x == revertedNumber / 10;\n}\n```',
 7845, 6932,
 '[{"input": "121", "output": "true"}, {"input": "-121", "output": "false"}, {"input": "10", "output": "false"}, {"input": "0", "output": "true"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 542, 487, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 160) DAY)),

('fizzbuzz问题', '写一个程序，输出从 1 到 n 数字的字符串表示。1. 如果 n 是3的倍数，输出"Fizz"；2. 如果 n 是5的倍数，输出"Buzz"；3. 如果 n 同时是3和5的倍数，输出 "FizzBuzz"。', '["算法", "数学", "字符串", "简单"]',
 '```javascript\nvar fizzBuzz = function(n) {\n    const result = [];\n    for (let i = 1; i <= n; i++) {\n        if (i % 3 === 0 && i % 5 === 0) {\n            result.push("FizzBuzz");\n        } else if (i % 3 === 0) {\n            result.push("Fizz");\n        } else if (i % 5 === 0) {\n            result.push("Buzz");\n        } else {\n            result.push(i.toString());\n        }\n    }\n    return result;\n};\n```',
 8947, 8702,
 '[{"input": "3", "output": "[\"1\",\"2\",\"Fizz\"]"}, {"input": "5", "output": "[\"1\",\"2\",\"Fizz\",\"4\",\"Buzz\"]"}, {"input": "15", "output": "[\"1\",\"2\",\"Fizz\",\"4\",\"Buzz\",\"Fizz\",\"7\",\"8\",\"Fizz\",\"Buzz\",\"11\",\"Fizz\",\"13\",\"14\",\"FizzBuzz\"]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 876, 845, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 100) DAY)),

('有效的括号', '给定一个只包括 \'(\', \')\', \'{\', \'}\', \'[\', \']\' 的字符串，判断字符串是否有效。有效字符串需满足：1.左括号必须用相同类型的右括号闭合。2.左括号必须以正确的顺序闭合。', '["算法", "栈", "字符串", "简单"]',
 '```python\ndef isValid(s):\n    stack = []\n    mapping = {")": "(", "}": "{", "]": "["}\n    \n    for char in s:\n        if char in mapping:\n            top_element = stack.pop() if stack else \'#\'\n            if mapping[char] != top_element:\n                return False\n        else:\n            stack.append(char)\n    \n    return not stack\n```',
 9234, 7623,
 '[{"input": "()", "output": "true"}, {"input": "()[]{}", "output": "true"}, {"input": "(]", "output": "false"}, {"input": "([)]", "output": "false"}, {"input": "{[]}", "output": "true"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 1243, 1078, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 140) DAY)),

('二进制求和', '给你两个二进制字符串，返回它们的和（用二进制表示）。', '["算法", "数学", "字符串", "位运算", "简单"]',
 '```cpp\nstring addBinary(string a, string b) {\n    string result = "";\n    int i = a.length() - 1, j = b.length() - 1;\n    int carry = 0;\n    \n    while (i >= 0 || j >= 0 || carry) {\n        int sum = carry;\n        if (i >= 0) sum += a[i--] - \'0\';\n        if (j >= 0) sum += b[j--] - \'0\';\n        \n        result = to_string(sum % 2) + result;\n        carry = sum / 2;\n    }\n    \n    return result;\n}\n```',
 6572, 5821,
 '[{"input": "11\\n1", "output": "100"}, {"input": "1010\\n1011", "output": "10101"}, {"input": "0\\n0", "output": "0"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 543, 498, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 190) DAY)),

('爬楼梯', '假设你正在爬楼梯。需要 n 阶你才能到达楼顶。每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？', '["算法", "动态规划", "简单"]',
 '```java\npublic int climbStairs(int n) {\n    if (n <= 2) return n;\n    \n    int[] dp = new int[n + 1];\n    dp[1] = 1;\n    dp[2] = 2;\n    \n    for (int i = 3; i <= n; i++) {\n        dp[i] = dp[i - 1] + dp[i - 2];\n    }\n    \n    return dp[n];\n}\n```',
 8423, 7234,
 '[{"input": "2", "output": "2"}, {"input": "3", "output": "3"}, {"input": "4", "output": "5"}, {"input": "5", "output": "8"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 934, 876, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 130) DAY)),

('移除元素', '给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。', '["算法", "数组", "双指针", "简单"]',
 '```javascript\nvar removeElement = function(nums, val) {\n    let i = 0;\n    for (let j = 0; j < nums.length; j++) {\n        if (nums[j] !== val) {\n            nums[i] = nums[j];\n            i++;\n        }\n    }\n    return i;\n};\n```',
 7123, 6743,
 '[{"input": "[3,2,2,3]\\n3", "output": "2, nums = [2,2,_,_]"}, {"input": "[0,1,2,2,3,0,4,2]\\n2", "output": "5, nums = [0,1,3,0,4,_,_,_]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 432, 398, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 110) DAY)),

('最大子序和', '给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。', '["算法", "数组", "分治", "动态规划", "简单"]',
 '```python\ndef maxSubArray(nums):\n    if not nums:\n        return 0\n    \n    curr_sum = max_sum = nums[0]\n    for i in range(1, len(nums)):\n        curr_sum = max(nums[i], curr_sum + nums[i])\n        max_sum = max(max_sum, curr_sum)\n    \n    return max_sum\n```',
 7854, 6721,
 '[{"input": "[-2,1,-3,4,-1,2,1,-5,4]", "output": "6"}, {"input": "[1]", "output": "1"}, {"input": "[5,4,-1,7,8]", "output": "23"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 764, 723, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 170) DAY)),

('加一', '给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。最高位数字存放在数组的首位，数组中每个元素只存储单个数字。', '["算法", "数组", "数学", "简单"]',
 '```cpp\nvector<int> plusOne(vector<int>& digits) {\n    int n = digits.size();\n    \n    for (int i = n - 1; i >= 0; i--) {\n        if (digits[i] < 9) {\n            digits[i]++;\n            return digits;\n        }\n        \n        digits[i] = 0;\n    }\n    \n    vector<int> result(n + 1, 0);\n    result[0] = 1;\n    return result;\n}\n```',
 6543, 5987,
 '[{"input": "[1,2,3]", "output": "[1,2,4]"}, {"input": "[4,3,2,1]", "output": "[4,3,2,2]"}, {"input": "[9,9,9]", "output": "[1,0,0,0]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 543, 521, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 150) DAY)),

('合并两个有序数组', '给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。', '["算法", "数组", "双指针", "排序", "简单"]',
 '```java\npublic void merge(int[] nums1, int m, int[] nums2, int n) {\n    int p1 = m - 1;\n    int p2 = n - 1;\n    int p = m + n - 1;\n    \n    while (p2 >= 0) {\n        if (p1 >= 0 && nums1[p1] > nums2[p2]) {\n            nums1[p--] = nums1[p1--];\n        } else {\n            nums1[p--] = nums2[p2--];\n        }\n    }\n}\n```',
 8742, 7654,
 '[{"input": "[1,2,3,0,0,0]\\n3\\n[2,5,6]\\n3", "output": "[1,2,2,3,5,6]"}, {"input": "[1]\\n1\\n[]\\n0", "output": "[1]"}, {"input": "[0]\\n0\\n[1]\\n1", "output": "[1]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 654, 623, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 120) DAY)),

('删除排序数组中的重复项', '给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。', '["算法", "数组", "双指针", "简单"]',
 '```javascript\nvar removeDuplicates = function(nums) {\n    if (nums.length === 0) return 0;\n    \n    let i = 0;\n    for (let j = 1; j < nums.length; j++) {\n        if (nums[j] !== nums[i]) {\n            i++;\n            nums[i] = nums[j];\n        }\n    }\n    \n    return i + 1;\n};\n```',
 9432, 8321,
 '[{"input": "[1,1,2]", "output": "2, nums = [1,2]"}, {"input": "[0,0,1,1,1,2,2,3,3,4]", "output": "5, nums = [0,1,2,3,4]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 845, 794, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 130) DAY)),

('搜索插入位置', '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。', '["算法", "数组", "二分查找", "简单"]',
 '```python\ndef searchInsert(nums, target):\n    left, right = 0, len(nums) - 1\n    \n    while left <= right:\n        mid = (left + right) // 2\n        if nums[mid] == target:\n            return mid\n        elif nums[mid] < target:\n            left = mid + 1\n        else:\n            right = mid - 1\n    \n    return left\n```',
 7654, 7123,
 '[{"input": "[1,3,5,6]\\n5", "output": "2"}, {"input": "[1,3,5,6]\\n2", "output": "1"}, {"input": "[1,3,5,6]\\n7", "output": "4"}, {"input": "[1,3,5,6]\\n0", "output": "0"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 763, 734, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 140) DAY)),

('找出数组中重复的数', '给定一个包含 n + 1 个整数的数组 nums，其数字都在 1 到 n 之间，假设只有一个重复的整数，找出这个重复的数。', '["算法", "数组", "双指针", "二分查找", "简单"]',
 '```java\npublic int findDuplicate(int[] nums) {\n    int slow = nums[0];\n    int fast = nums[0];\n    \n    // 找到环中的相遇点\n    do {\n        slow = nums[slow];\n        fast = nums[nums[fast]];\n    } while (slow != fast);\n    \n    // 找到环的入口点\n    slow = nums[0];\n    while (slow != fast) {\n        slow = nums[slow];\n        fast = nums[fast];\n    }\n    \n    return slow;\n}\n```',
 5421, 4321,
 '[{"input": "[1,3,4,2,2]", "output": "2"}, {"input": "[3,1,3,4,2]", "output": "3"}, {"input": "[1,1]", "output": "1"}, {"input": "[1,1,2]", "output": "1"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 621, 542, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 160) DAY)),

('只出现一次的数字', '给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。', '["算法", "位运算", "哈希表", "简单"]',
 '```cpp\nint singleNumber(vector<int>& nums) {\n    int result = 0;\n    for (int num : nums) {\n        result ^= num;\n    }\n    return result;\n}\n```',
 8765, 8432,
 '[{"input": "[2,2,1]", "output": "1"}, {"input": "[4,1,2,1,2]", "output": "4"}, {"input": "[1]", "output": "1"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 874, 843, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 120) DAY)),

('汉明距离', '两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。给出两个整数 x 和 y，计算它们之间的汉明距离。', '["算法", "位运算", "简单"]',
 '```javascript\nvar hammingDistance = function(x, y) {\n    let xor = x ^ y;\n    let distance = 0;\n    \n    while (xor > 0) {\n        distance += xor & 1;\n        xor >>= 1;\n    }\n    \n    return distance;\n};\n```',
 6543, 6321,
 '[{"input": "1\\n4", "output": "2"}, {"input": "3\\n1", "output": "1"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 432, 421, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 110) DAY)),

('翻转二叉树', '翻转一棵二叉树。', '["算法", "树", "深度优先搜索", "广度优先搜索", "简单"]',
 '```python\ndef invertTree(root):\n    if not root:\n        return None\n    \n    root.left, root.right = root.right, root.left\n    invertTree(root.left)\n    invertTree(root.right)\n    \n    return root\n```',
 7321, 7123,
 '[{"input": "[4,2,7,1,3,6,9]", "output": "[4,7,2,9,6,3,1]"}, {"input": "[2,1,3]", "output": "[2,3,1]"}, {"input": "[]", "output": "[]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 765, 743, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 130) DAY)),

('二叉树的最大深度', '给定一个二叉树，找出其最大深度。二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。', '["算法", "树", "深度优先搜索", "广度优先搜索", "简单"]',
 '```java\npublic int maxDepth(TreeNode root) {\n    if (root == null) {\n        return 0;\n    }\n    \n    int leftDepth = maxDepth(root.left);\n    int rightDepth = maxDepth(root.right);\n    \n    return Math.max(leftDepth, rightDepth) + 1;\n}\n```',
 8321, 8123,
 '[{"input": "[3,9,20,null,null,15,7]", "output": "3"}, {"input": "[1,null,2]", "output": "2"}, {"input": "[]", "output": "0"}, {"input": "[0]", "output": "1"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 873, 865, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 140) DAY)),

('对称二叉树', '给定一个二叉树，检查它是否是镜像对称的。', '["算法", "树", "深度优先搜索", "广度优先搜索", "简单"]',
 '```cpp\nbool isSymmetric(TreeNode* root) {\n    if (!root) return true;\n    return isMirror(root->left, root->right);\n}\n\nbool isMirror(TreeNode* left, TreeNode* right) {\n    if (!left && !right) return true;\n    if (!left || !right) return false;\n    \n    return (left->val == right->val) && \n           isMirror(left->left, right->right) && \n           isMirror(left->right, right->left);\n}\n```',
 6543, 5987,
 '[{"input": "[1,2,2,3,4,4,3]", "output": "true"}, {"input": "[1,2,2,null,3,null,3]", "output": "false"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 652, 623, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 150) DAY)),

('二叉树的层序遍历', '给你一个二叉树，请你返回其按 层序遍历 得到的节点值。', '["算法", "树", "广度优先搜索", "二叉树", "简单"]',
 '```javascript\nvar levelOrder = function(root) {\n    if (!root) return [];\n    \n    const result = [];\n    const queue = [root];\n    \n    while (queue.length) {\n        const levelSize = queue.length;\n        const currentLevel = [];\n        \n        for (let i = 0; i < levelSize; i++) {\n            const node = queue.shift();\n            currentLevel.push(node.val);\n            \n            if (node.left) queue.push(node.left);\n            if (node.right) queue.push(node.right);\n        }\n        \n        result.push(currentLevel);\n    }\n    \n    return result;\n};\n```',
 7321, 6543,
 '[{"input": "[3,9,20,null,null,15,7]", "output": "[[3],[9,20],[15,7]]"}, {"input": "[1]", "output": "[[1]]"}, {"input": "[]", "output": "[]"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 723, 698, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 170) DAY)),

('整数反转', '给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。假设我们的环境只能存储得下 32 位的有符号整数。', '["算法", "数学", "简单"]',
 '```python\ndef reverse(x):\n    result = 0\n    abs_x = abs(x)\n    \n    while abs_x > 0:\n        result = result * 10 + abs_x % 10\n        abs_x //= 10\n    \n    if result > 2**31 - 1:\n        return 0\n    \n    return result if x > 0 else -result\n```',
 9876, 8765,
 '[{"input": "123", "output": "321"}, {"input": "-123", "output": "-321"}, {"input": "120", "output": "21"}, {"input": "0", "output": "0"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 876, 843, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY)),

('验证回文串', '给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。', '["算法", "双指针", "字符串", "简单"]',
 '```java\npublic boolean isPalindrome(String s) {\n    int left = 0, right = s.length() - 1;\n    \n    while (left < right) {\n        while (left < right && !Character.isLetterOrDigit(s.charAt(left))) {\n            left++;\n        }\n        while (left < right && !Character.isLetterOrDigit(s.charAt(right))) {\n            right--;\n        }\n        \n        if (Character.toLowerCase(s.charAt(left)) != Character.toLowerCase(s.charAt(right))) {\n            return false;\n        }\n        \n        left++;\n        right--;\n    }\n    \n    return true;\n}\n```',
 8765, 7654,
 '[{"input": "A man, a plan, a canal: Panama", "output": "true"}, {"input": "race a car", "output": "false"}, {"input": " ", "output": "true"}, {"input": "0P", "output": "false"}]',
 '{"timeLimit": 500, "memoryLimit": 128, "stackLimit": 64}',
 765, 721, 2, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 140) DAY))


SELECT
    qs.id AS submitId,
    u.id AS userId,
    u.userName AS userName,
    u.userAvatar AS userAvatar,
    q.id AS questionId,
    q.title AS questionTitle,
    qs.language AS language,
  CONCAT(ROUND(CHAR_LENGTH(qs.code) / 1024, 2), ' KB') AS codeLength,
  qs.createTime AS submitTime,
  NULL AS timeUse,
  NULL AS memoryUse,
  NULL AS status,
  qs.judgeInfo AS judgeInfo
FROM
    question_submit qs
    LEFT JOIN user u ON qs.userId = u.id
    LEFT JOIN question q ON qs.questionId = q.id
WHERE
    (NULL IS NULL OR u.userName LIKE CONCAT('%', NULL, '%'))
  AND (NULL IS NULL OR q.title LIKE CONCAT('%', NULL, '%'))
  AND (NULL IS NULL OR JSON_EXTRACT(qs.judgeInfo, '$.status') = NULL)
  AND (NULL IS NULL OR qs.language = NULL)
ORDER BY
    qs.createTime DESC
    LIMIT 20 OFFSET 0
