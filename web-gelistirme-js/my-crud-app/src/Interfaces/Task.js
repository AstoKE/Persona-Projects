/**
 * Task arayüzü (Interface)
 *
 * @typedef {Object} Task
 * @property {number}  id        - Benzersiz kimlik
 * @property {string}  title     - Görev başlığı
 * @property {string}  category  - Kategori (İş / Kişisel / Eğitim / Diğer)
 * @property {string}  priority  - Öncelik (Düşük / Orta / Yüksek)
 * @property {boolean} completed - Tamamlandı mı?
 * @property {string}  createdAt - Oluşturulma tarihi (ISO string)
 */

export const CATEGORIES = ['İş', 'Kişisel', 'Eğitim', 'Diğer'];
export const PRIORITIES  = ['Düşük', 'Orta', 'Yüksek'];

export const PRIORITY_COLORS = {
  'Düşük':  'bg-green-100 text-green-700',
  'Orta':   'bg-yellow-100 text-yellow-700',
  'Yüksek': 'bg-red-100 text-red-700',
};

export const CATEGORY_COLORS = {
  'İş':      'bg-blue-100 text-blue-700',
  'Kişisel': 'bg-purple-100 text-purple-700',
  'Eğitim':  'bg-orange-100 text-orange-700',
  'Diğer':   'bg-gray-100 text-gray-700',
};

/**
 * Yeni bir Task nesnesi oluşturur.
 * @param {string} title
 * @param {string} category
 * @param {string} priority
 * @returns {Task}
 */
export function createTask(title, category, priority) {
  return {
    id:        Date.now(),
    title:     title.trim(),
    category,
    priority,
    completed: false,
    createdAt: new Date().toISOString(),
  };
}
